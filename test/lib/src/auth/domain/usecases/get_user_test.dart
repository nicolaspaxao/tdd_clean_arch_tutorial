import 'package:dartz/dartz.dart';
import 'package:dummy_project/src/auth/domain/entities/user.dart';
import 'package:dummy_project/src/auth/domain/repositories/auth_repository.dart';
import 'package:dummy_project/src/auth/domain/usecases/get_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo_mock.dart';

void main() {
  late AuthRepository repository;
  late GetUser usecase;

  setUpAll(() {
    repository = MockAuthRepository();
    usecase = GetUser(repository);
  });

  const tResponse = [User.empty()];
  test(
    'should call the [AuthRepository.getUsers] and it should return [List<User>]',
    () async {
      //* Arrange

      when(() => repository.getUser()).thenAnswer(
        (_) async => const Right(tResponse),
      );

      //* Act

      final result = await usecase();

      //* Assert
      expect(result, equals(const Right<dynamic, List<User>>(tResponse)));

      verify(() => repository.getUser()).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
