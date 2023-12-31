import 'package:dummy_project/core/usecases/usecase.dart';
import 'package:dummy_project/core/utils/typedef.dart';
import 'package:dummy_project/src/auth/domain/entities/user.dart';
import 'package:dummy_project/src/auth/domain/repositories/auth_repository.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  final AuthRepository _repository;

  GetUsers(this._repository);

  @override
  ResultFuture<List<User>> call() async => _repository.getUser();
}
