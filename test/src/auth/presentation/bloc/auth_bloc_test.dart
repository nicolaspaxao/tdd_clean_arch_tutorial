import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dummy_project/core/errors/failure.dart';
import 'package:dummy_project/src/auth/domain/usecases/create_user.dart';
import 'package:dummy_project/src/auth/domain/usecases/get_user.dart';
import 'package:dummy_project/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;

  late AuthBloc bloc;

  const CreateUserParams tCreateUser = CreateUserParams.empty();
  const ApiFailure tApiFailure =
      ApiFailure(message: 'message', statusCode: 400);

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    bloc = AuthBloc(createUser: createUser, getUser: getUsers);
  });

  //For which test we close the bloc store
  tearDown(() => bloc.close());

  test('initial state should be [AuthInitial]', () async {
    expect(bloc.state, const AuthInitial());
  });

  group('createUser', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [CreatingUser, UserCreated] when sucessful',
      build: () {
        when(() => createUser(tCreateUser)).thenAnswer(
          (invocation) async => const Right(null),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        CreateUserEvent(
          createdAt: tCreateUser.createdAt,
          name: tCreateUser.name,
          avatar: tCreateUser.avatar,
        ),
      ),
      expect: () => [
        const CreatingUser(),
        const UserCreated(),
      ],
      verify: (bloc) {
        verify(() => createUser(tCreateUser));
        verifyNoMoreInteractions(createUser);
      },
    );
    blocTest<AuthBloc, AuthState>(
      'should emit [CreatingUser, AuthError] when unsucessful',
      build: () {
        when(() => createUser(tCreateUser))
            .thenAnswer((_) async => const Left(tApiFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(
        CreateUserEvent(
          createdAt: tCreateUser.createdAt,
          name: tCreateUser.name,
          avatar: tCreateUser.avatar,
        ),
      ),
      expect: () => <AuthState>[
        const CreatingUser(),
        AuthError(tApiFailure.errorMessage)
      ],
      verify: (bloc) {
        verify(() => createUser(tCreateUser));
        verifyNoMoreInteractions(createUser);
      },
    );
  });

  group('getUser', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [GettingUsers, UsersLoaded] when sucessful',
      build: () {
        when(() => getUsers()).thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetUsersEvent()),
      expect: () => const <AuthState>[
        GettingUsers(),
        UsersLoaded([]),
      ],
      verify: (bloc) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [GettingUsers, AuthError] when unsucessful',
      build: () {
        when(() => getUsers()).thenAnswer((_) async => const Left(tApiFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetUsersEvent()),
      expect: () => <AuthState>[
        const GettingUsers(),
        AuthError(tApiFailure.errorMessage),
      ],
      verify: (bloc) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );
  });
}
