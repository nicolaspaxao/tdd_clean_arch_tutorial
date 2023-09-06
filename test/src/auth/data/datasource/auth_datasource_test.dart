import 'dart:convert';

import 'package:dummy_project/core/errors/exceptions.dart';
import 'package:dummy_project/core/utils/constants.dart';
import 'package:dummy_project/src/auth/data/datasource/auth_datasource.dart';
import 'package:dummy_project/src/auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthDatasource datasource;

  setUp(() {
    client = MockClient();
    datasource = AuthDatasourceImpl(client: client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test(
      'should complete succesfully when the status code is 200 or 201',
      () async {
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('user created successfully', 201),
        );

        final method = datasource.createUser(
          createdAt: 'createdAt',
          name: 'name',
          avatar: 'avatar',
        );

        expect(method, completes);

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl/users'),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test(
      'should complete succesfully when the status code is not 200 or 201',
      () async {
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('Invalid data sended', 400),
        );

        final method = datasource.createUser;

        expect(
          () => method(
            createdAt: 'createdAt',
            name: 'name',
            avatar: 'avatar',
          ),
          throwsA(
            const APIException(message: 'Invalid data sended', statusCode: 400),
          ),
        );

        verify(
          () => client.post(Uri.parse('$kBaseUrl/users'),
              body: jsonEncode({
                'createdAt': 'createdAt',
                'name': 'name',
                'avatar': 'avatar',
              })),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });

  group('getUsers', () {
    final tUsers = [const UserModel.empty()];
    test(
      'should return a [List<Users>] when the status code is 200',
      () async {
        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 200),
        );

        final result = await datasource.getUsers();

        expect(result, equals(tUsers));

        verify(() => client.get(Uri.parse('$kBaseUrl/users'))).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test(
      'should return a [APIException] when the status code is not 200',
      () async {
        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode('Error to get users'), 404),
        );

        final method = datasource.getUsers;

        expect(
          () => method(),
          throwsA(
            APIException(
                message: jsonEncode('Error to get users'), statusCode: 404),
          ),
        );

        verify(() => client.get(Uri.parse('$kBaseUrl/users'))).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });
}
