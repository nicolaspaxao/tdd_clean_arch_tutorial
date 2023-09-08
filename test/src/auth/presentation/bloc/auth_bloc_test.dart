import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
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

  const tCreateUser = CreateUserParams.empty();

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
        when(() => createUser(any())).thenAnswer(
          (invocation) async => const Right(null),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const CreateUserEvent(
          createdAt: 'createdAt',
          name: 'name',
          avatar: 'avatar',
        ),
      ),
      expect: () => [const CreatingUser(), const UserCreated()],
      verify: (bloc) => createUser(tCreateUser),
      errors: () => [const AuthError('Error')],
    );
  });
}
