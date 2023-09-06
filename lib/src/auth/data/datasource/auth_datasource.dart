import 'dart:convert';

import 'package:dummy_project/core/errors/exceptions.dart';
import 'package:dummy_project/core/utils/constants.dart';
import 'package:dummy_project/core/utils/typedef.dart';
import 'package:dummy_project/src/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthDatasource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });
  Future<List<UserModel>> getUsers();
}

class AuthDatasourceImpl implements AuthDatasource {
  AuthDatasourceImpl({required this.client});

  final http.Client client;

  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      final response = await client.post(
        Uri.parse('$kBaseUrl/users'),
        body: jsonEncode({
          'createdAt': 'createdAt',
          'name': 'name',
          'avatar': 'avatar',
        }),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await client.get(Uri.parse('$kBaseUrl/users'));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      } else {
        return List<DataMap>.from(jsonDecode(response.body) as List)
            .map((e) => UserModel.fromMap(e))
            .toList();
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 500);
    }
  }
}
