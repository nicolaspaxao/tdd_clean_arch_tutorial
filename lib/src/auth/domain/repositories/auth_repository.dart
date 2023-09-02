import 'package:dummy_project/src/auth/domain/entities/user.dart';

import '../../../../core/utils/typedef.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  ResultFuture<List<User>> getUser();
}
