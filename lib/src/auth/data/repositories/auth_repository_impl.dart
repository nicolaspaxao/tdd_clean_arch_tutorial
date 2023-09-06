import 'package:dartz/dartz.dart';
import 'package:dummy_project/core/errors/exceptions.dart';
import 'package:dummy_project/core/errors/failure.dart';
import 'package:dummy_project/core/utils/typedef.dart';
import 'package:dummy_project/src/auth/data/datasource/auth_datasource.dart';
import 'package:dummy_project/src/auth/domain/entities/user.dart';
import 'package:dummy_project/src/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.datasource);
  final AuthDatasource datasource;

  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      await datasource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUser() async {
    try {
      final result = await datasource.getUsers();
      return Right(result);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
