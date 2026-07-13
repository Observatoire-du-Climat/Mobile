import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/web_providers/user_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:mobile/web_providers/user_provider.dart';
import 'package:mobile/utils/secure_storage.dart';

import 'user_provider_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
  MockSpec<SecureStorage>(as: #MockSecureStorage),
])
void main() {
  late MockHttpClient client;
  late MockSecureStorage storage;
  late UserProvider provider;

  setUpAll(() async {
    dotenv.loadFromString(envString: 'BASE_API_URL=http://localhost:8080');
  });

  setUp(() {
    client = MockHttpClient();
    storage = MockSecureStorage();
    provider = UserProvider(storage, client);
  });

  group('registerUser', () {
    test('Register success', () async {
      when(
        client.post(
          Uri.parse('http://localhost:8080/register'),
          headers: {'Content-Type': 'application/json'},
          body: '{"name":"David","email":"test@test.ch","password":"1234"}',
        ),
      ).thenAnswer(
            (_) async => http.Response(
          '{"id":1,"name":"David","email":"test@test.ch"}',
          201,
        ),
      );

      when(storage.writeUserId(any)).thenAnswer((_) async {});

      final user = await provider.createUser('David', 'test@test.ch', '1234');

      expect(user.id, 1);
      expect(user.name, 'David');
      expect(user.email, 'test@test.ch');

      verify(storage.writeUserId(1)).called(1);
    });

    test('Register failed', () async {
      when(
        client.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
            (_) async => http.Response('Bad Request', 400),
      );

      expect(
            () => provider.createUser('test', 'wrong@test.ch', 'wrong'),
        throwsException,
      );

      verifyNever(storage.writeUserId(any));
    });
  });

  group('loginUser', () {
    test('Login success', () async {
      when(
        client.post(
          Uri.parse('http://localhost:8080/login'),
          headers: {'Content-Type': 'application/json'},
          body: '{"email":"test@test.ch","password":"1234"}',
        ),
      ).thenAnswer(
            (_) async => http.Response(
          '{"id":1,"name":"David","email":"test@test.ch"}',
          200,
        ),
      );

      when(storage.writeUserId(any)).thenAnswer((_) async {});

      final user = await provider.loginUser('test@test.ch', '1234');

      expect(user.id, 1);
      expect(user.name, 'David');
      expect(user.email, 'test@test.ch');

      verify(storage.writeUserId(1)).called(1);
    });

    test('Login failed', () async {
      when(
        client.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
            (_) async => http.Response('Unauthorized', 401),
      );

      expect(
            () => provider.loginUser('wrong@test.ch', 'wrong'),
        throwsException,
      );

      verifyNever(storage.writeUserId(any));
    });
  });
}