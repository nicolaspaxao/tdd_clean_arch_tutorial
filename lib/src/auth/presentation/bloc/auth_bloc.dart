import 'package:bloc/bloc.dart';
import 'package:dummy_project/src/auth/domain/entities/user.dart';
import 'package:dummy_project/src/auth/domain/usecases/get_user.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/create_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CreateUser createUser;
  final GetUsers getUser;

  AuthBloc({
    required this.createUser,
    required this.getUser,
  }) : super(const AuthInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUsersEvent>(_getUsersHandler);
  }

  Future<void> _createUserHandler(
    CreateUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const CreatingUser());

    final result = await createUser(CreateUserParams(
      createdAt: event.createdAt,
      name: event.name,
      avatar: event.avatar,
    ));

    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (_) => emit(const UserCreated()),
    );
  }

  Future<void> _getUsersHandler(
    GetUsersEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const GettingUsers());

    final result = await getUser();

    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (sucess) => emit(UsersLoaded(sucess)),
    );
  }
}
