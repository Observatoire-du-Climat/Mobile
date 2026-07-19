import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/models/temperature.dart';
import 'package:mobile/utils/secure_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/web_providers/measure_provider.dart';
import 'user_provider_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
  MockSpec<SecureStorage>(as: #MockSecureStorage),
])
void main() {
  late MockHttpClient mockClient;
  late MockSecureStorage storage;
  late MeasureProvider measureProvider;

  const baseUrl = "http://localhost:8080/api";

  setUpAll(() async {
    dotenv.loadFromString(envString: 'BASE_API_URL=http://localhost:8080/api');
  });

  setUp(() {
    mockClient = MockHttpClient();
    storage = MockSecureStorage();
    measureProvider = MeasureProvider(storage, mockClient);

    storage.writeUserId(1);
  });

  group('getUserMeasures', () {
    test('getUserMeasures successful', () async {
      when(storage.getUserId())
          .thenAnswer((_) async => '1');

      final responseBody = jsonEncode([
        {
          'id': 10,
          'date': '2026-07-19',
          'location': 'Lausanne',
          'type': 'TEMPERATURE',
        },
        {
          'id': 11,
          'date': '2026-07-18',
          'location': 'Yverdon-les-Bains',
          'type': 'SNOW_HEIGHT',
        },
      ]);

      when(
        mockClient.get(
          Uri.parse('$baseUrl/measures/user/1'),
        ),
      ).thenAnswer(
            (_) async => http.Response(responseBody, 200),
      );

      final measures = await measureProvider.getUserMeasures();

      expect(measures, hasLength(2));
      expect(measures.first.id, 10);
      expect(measures.first.location, 'Lausanne');

      verify(storage.getUserId()).called(1);

      verify(
        mockClient.get(
          Uri.parse('$baseUrl/measures/user/1'),
        ),
      ).called(1);
    });

    test('getUserMeasures, no user connected', () async {
      when(storage.getUserId())
          .thenAnswer((_) async => null);

      expect(
            () => measureProvider.getUserMeasures(),
        throwsException,
      );

      verify(storage.getUserId()).called(1);

      verifyNever(
        mockClient.get(any),
      );
    });

    test('getUserMeasures, retrieval failed', () async {
      when(storage.getUserId())
          .thenAnswer((_) async => '1');

      when(
        mockClient.get(
          Uri.parse('$baseUrl/measures/user/1'),
        ),
      ).thenAnswer(
            (_) async => http.Response(
          'Failed to load measures',
          500,
        ),
      );

      expect(
            () => measureProvider.getUserMeasures(),
        throwsException,
      );

      verifyNever(mockClient.get(Uri.parse('$baseUrl/measures/user/1')));
    });
  });

  group('createTemperature', () {
    test('createTemperature successful', () async {
      when(storage.getUserId())
          .thenAnswer((_) async => '1');

      final responseBody = jsonEncode({
        'id': 10,
        'date': '2026-07-19',
        'location': 'Lausanne',
        'type': 'TEMPERATURE',
        'degree': 25,
      });

      when(mockClient.send(any)).thenAnswer(
            (_) async => http.StreamedResponse(
          Stream.value(utf8.encode(responseBody)),
          201,
        ),
      );

      final Temperature temperature = await measureProvider.createTemperature(
        DateTime(2026, 7, 19),
        'Lausanne',
        25,
        null,
      );

      expect(temperature.id, 10);
      expect(temperature.location, 'Lausanne');
      expect(temperature.degree, 25);

      verify(storage.getUserId()).called(1);
      verify(mockClient.send(any)).called(1);
    });

    test('createTemperature, no user connected', () async {
      when(storage.getUserId())
          .thenAnswer((_) async => null);

      expect(() => measureProvider.createTemperature(
          DateTime(2026, 7, 19),
          'Lausanne',
          25,
          null,
        ),
        throwsException,
      );

      verify(storage.getUserId()).called(1);
      verifyNever(mockClient.send(any));
    });

    test('CreateTemperature, user is not valid', () async {
      when(storage.getUserId())
          .thenAnswer((_) async => '1');

      when(mockClient.send(any)).thenAnswer(
            (_) async => http.StreamedResponse(
          Stream.value(
            utf8.encode('User is not validated'),
          ),
          403,
        ),
      );

      expect(() => measureProvider.createTemperature(
          DateTime(2026, 7, 19),
          'Lausanne',
          25,
          null,
        ),
        throwsException,
      );

      verifyNever(mockClient.send(any));
    });
  });

  group('updateTemperature', () {
    test('updateTemperature successful', () async {
      when(storage.getUserId())
          .thenAnswer((_) async => '1');

      final requestBody = jsonEncode({
        'userId': '1',
        'date': '2026-07-20',
        'location': 'Lausanne',
        'degree': 28,
      });

      final responseBody = jsonEncode({
        'id': 10,
        'date': '2026-07-20',
        'location': 'Lausanne',
        'type': 'TEMPERATURE',
        'degree': 28,
      });

      when(mockClient.put(
          Uri.parse('$baseUrl/measures/temperature/10'),
          headers: {'Content-Type': 'application/json'},
          body: requestBody,
        ),
      ).thenAnswer(
            (_) async => http.Response(responseBody, 200),
      );

      final temperature = await measureProvider.updateTemperature(
        10,
        DateTime(2026, 7, 20),
        'Lausanne',
        28,
      );

      expect(temperature.id, 10);
      expect(temperature.location, 'Lausanne');
      expect(temperature.degree, 28);

      verify(
        mockClient.put(
          Uri.parse('$baseUrl/measures/temperature/10'),
          headers: {'Content-Type': 'application/json'},
          body: requestBody,
        ),
      ).called(1);
    });

    test('updateTemperature, update failed', () async {
      when(mockClient.send(any)).thenAnswer(
            (_) async => http.StreamedResponse(
          Stream.value(
            utf8.encode('Failed to update measure'),
          ),
          400,
        ),
      );

      expect(
            () => measureProvider.updateTemperature(
          10,
          DateTime(2026, 7, 20),
          'Lausanne',
          28,
        ),
        throwsException,
      );

      verifyNever(mockClient.send(any));
    });
  });

  group('deleteMeasure', () {
    test('deleteMeasure successful', () async {
      when(
        mockClient.delete(
          Uri.parse('$baseUrl/measures/10'),
        ),
      ).thenAnswer(
            (_) async => http.Response('', 204),
      );

      await expectLater(
        measureProvider.deleteMeasure(10),
        completes,
      );

      verify(
        mockClient.delete(
          Uri.parse('$baseUrl/measures/10'),
        ),
      ).called(1);
    });

    test('deleteTemperature error', () async {
      when(
        mockClient.delete(
          Uri.parse('$baseUrl/measures/10'),
        ),
      ).thenAnswer(
            (_) async => http.Response(
          'Measure not found',
          404,
        ),
      );

      expect(
            () => measureProvider.deleteMeasure(10),
        throwsException,
      );

      verify(mockClient.delete(Uri.parse('$baseUrl/measures/10'),),).called(1);
    });
  });

}