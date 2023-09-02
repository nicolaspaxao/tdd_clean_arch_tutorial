import 'package:dartz/dartz.dart';
import 'package:dummy_project/src/auth/domain/entities/user.dart';

abstract class AuthRepository {
  const AuthRepository();

  Future<Either<Exception, void>> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<Either<Exception, List<User>>> getUser();
}
