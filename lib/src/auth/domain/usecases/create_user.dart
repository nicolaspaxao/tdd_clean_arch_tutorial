// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:dummy_project/core/usecases/usecase.dart';
import 'package:dummy_project/core/utils/typedef.dart';

import '../repositories/auth_repository.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  final AuthRepository _repository;

  CreateUser(this._repository);

  @override
  ResultFuture call(CreateUserParams params) async {
    return _repository.createUser(
      createdAt: params.createdAt,
      name: params.name,
      avatar: params.avatar,
    );
  }
}

class CreateUserParams extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserParams.empty()
      : this(
          avatar: '_empy.string',
          name: '_empy.string',
          createdAt: '_empy.string',
        );

  const CreateUserParams({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  @override
  List<Object> get props => [createdAt, name, avatar];
}
