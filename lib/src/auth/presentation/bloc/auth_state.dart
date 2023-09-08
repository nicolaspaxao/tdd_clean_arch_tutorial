part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class CreatingUser extends AuthState {
  const CreatingUser();
}

final class GettingUsers extends AuthState {
  const GettingUsers();
}

final class UserCreated extends AuthState {
  const UserCreated();
}

final class UsersLoaded extends AuthState {
  const UsersLoaded(this.users);
  final List<User> users;

  @override
  List<Object> get props => users.map((e) => e.id!).toList();
}

final class AuthError extends AuthState {
  const AuthError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
