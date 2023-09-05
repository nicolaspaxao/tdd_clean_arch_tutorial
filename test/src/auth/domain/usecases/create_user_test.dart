/*
* 1. What does the class depend on 
*  -- AuthRepository
* 2. How can we create a fake version of the dependecy
*  -- Use MockTail 
* 3. How do we control what our dependecies do
*  -- Using the Mocktail's APIs
*/

import 'package:dartz/dartz.dart';
import 'package:dummy_project/src/auth/domain/repositories/auth_repository.dart';
import 'package:dummy_project/src/auth/domain/usecases/create_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo_mock.dart';

void main() {
  late CreateUser usecase;
  late AuthRepository repository;

  const params = CreateUserParams.empty();

  setUpAll(() {
    repository = MockAuthRepository();
    usecase = CreateUser(repository);
  });

  test('Should call the [AuthRepository.createUser]', () async {
    //* Arrange: All that we need to test
    //* STUB
    when(() => repository.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        )).thenAnswer((_) async => const Right(null));

    //* Act: Envoke the callers
    final result = await usecase(params);

    //* Assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => repository.createUser(
          createdAt: params.createdAt,
          name: params.name,
          avatar: params.avatar),
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
}
