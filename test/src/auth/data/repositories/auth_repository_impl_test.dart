import 'package:dartz/dartz.dart';
import 'package:dummy_project/core/errors/exceptions.dart';
import 'package:dummy_project/core/errors/failure.dart';
import 'package:dummy_project/src/auth/data/datasource/auth_datasource.dart';
import 'package:dummy_project/src/auth/data/repositories/auth_repository_impl.dart';
import 'package:dummy_project/src/auth/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepositoryImpl {}

class MockAuthDatasource extends Mock implements AuthDatasource {}

void main() {
  late MockAuthDatasource datasource;
  late AuthRepositoryImpl repository;

  const createdAt = 'whatever.createdAt';
  const name = 'whatever.name';
  const avatar = 'whatever.avatar';

  const tException =
      APIException(message: 'Unknow Error Occured', statusCode: 500);

  setUp(() {
    datasource = MockAuthDatasource();
    repository = AuthRepositoryImpl(datasource);
  });

  group('createUser', () {
    test(
      'should call the [RemoteDatasource.createUser] and complete successfully when the call to the remote source is sucessful',
      () async {
        //Arrange
        when(
          () => datasource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: 'avatar')),
        ).thenAnswer((_) async => Future.value());

        //Act
        final result = await repository.createUser(
            createdAt: createdAt, name: name, avatar: avatar);

        //Assert
        expect(result, equals(const Right(null)));
        verify(
          () => datasource.createUser(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          ),
        ).called(1);

        verifyNoMoreInteractions(datasource);
      },
    );

    test(
        'should return [APIFailure] when the call to the remote source is unsuccessful',
        () async {
      //Arrange
      when(
        () => datasource.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar')),
      ).thenThrow(tException);

      //Act
      final result = await repository.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      //Assert
      expect(
        result,
        equals(Left(ApiFailure.fromException(tException))),
      );

      verify(() => datasource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(datasource);
    });
  });

  group('getUsers', () {
    test(
      'should call the [RemoteDatasource.getUsers] and return [List<User>] when call to remote source is successful',
      () async {
        when(() => datasource.getUsers()).thenAnswer((_) async => []);

        final result = await repository.getUser();

        expect(result, isA<Right<dynamic, List<User>>>());
        verify(() => datasource.getUsers()).called(1);
        verifyNoMoreInteractions(datasource);
      },
    );
    test(
      'should return [APIFailure] when the call to the remote source is unsuccessful',
      () async {
        when(() => datasource.getUsers()).thenThrow(tException);

        final result = await repository.getUser();

        expect(result, equals(Left(ApiFailure.fromException(tException))));
        verify(() => datasource.getUsers()).called(1);
        verifyNoMoreInteractions(datasource);
      },
    );
  });
}
