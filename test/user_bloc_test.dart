import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/bloc/user_bloc.dart';
import 'package:mobile/bloc/user_event.dart';
import 'package:mobile/bloc/user_state.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/repositories/user_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import 'user_bloc_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<UserRepository>(as: #MockUserRepository),
])
void main() {

  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
  });


  test('Initial state is UserNotConnected', () {
    final bloc = UserBloc(mockUserRepository,);

    expect(bloc.state, isA<UserNotConnected>());

    bloc.close();
  });

  group('UserBloc', () {

    blocTest(
        'loginUser successful',
        build: () {
          when(
            mockUserRepository.loginUser(
              'test@test.ch',
              'password',
            ),
          ).thenAnswer((_) async => User(
              id: 1,
              name: 'Test',
              email: 'test@test.ch',
              isValid: true,
            ),
          );

          return UserBloc(mockUserRepository);
        },
        act: (bloc) => bloc.add(
          LoginRequest(
            email: 'test@test.ch',
            password: 'password',
          ),
        ),
        expect: () => [
          isA<UserLoading>(),
          isA<UserConnected>(),
        ],
    );

    blocTest<UserBloc, UserState>(
      'loginUser failed',
      build: () {
        when(
          mockUserRepository.loginUser(
            any,
            any,
          ),
        ).thenThrow(
          Exception('Wrong credentials'),
        );

        return UserBloc(mockUserRepository,);
      },
      act: (bloc) => bloc.add(
        LoginRequest(
          email: 'test@test.ch',
          password: 'wrong-password',
        ),
      ),
      expect: () => [
        isA<UserLoading>(),
        isA<UserError>(),
      ],
    );

    blocTest<UserBloc, UserState>(
      'createUser successful',
      build: () {
        when(
          mockUserRepository.createUser(
            'Test',
            'test@test.ch',
            'password',
          ),
        ).thenAnswer((_) async => User(
            id: 1,
            name: 'Test',
            email: 'test@test.ch',
            isValid: false,
          ),
        );

        return UserBloc(mockUserRepository);
      },
      act: (bloc) => bloc.add(
        RegisterRequest(
          name: 'Test',
          email: 'test@test.ch',
          password: 'password',
        ),
      ),
      expect: () => [
        isA<UserLoading>(),
        isA<UserConnected>(),
      ],
    );

    blocTest<UserBloc, UserState>(
      'createUser failed',
      build: () {
        when(
          mockUserRepository.createUser(
            any,
            any,
            any,
          ),
        ).thenThrow(
          Exception('Email already exists'),
        );

        return UserBloc(mockUserRepository);
      },
      act: (bloc) => bloc.add(
        RegisterRequest(
          name: 'Test',
          email: 'test@test.ch',
          password: 'password',
        ),
      ),
      expect: () => [
        isA<UserLoading>(),
        isA<UserError>(),
      ],
    );


    blocTest(
        'getCurrentUser details',
        build: () {
          when(
            mockUserRepository.getCurrentUser(),
          ).thenAnswer((_) async => User(
            id: 1,
            name: 'Test',
            email: 'test@test.ch',
            isValid: false,
          ),
          );

          return UserBloc(mockUserRepository);
        },
        act: (bloc) => bloc.add(
          UserRequest(),
        ),
        expect: () => [
          isA<UserLoading>(),
          isA<UserConnected>(),
        ],
    );

  });


}