import 'dart:convert';

import 'package:dummy_project/core/utils/typedef.dart';
import 'package:dummy_project/src/auth/data/models/user_model.dart';
import 'package:dummy_project/src/auth/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();
  test('should be a subclas of [User] entity', () {
    //Arrange

    //Act

    //Assert
    expect(tModel, isA<User>());
  });

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should return a [UserModel] with the right data', () {
      //Arrange

      //Act
      final result = UserModel.fromMap(tMap);

      //Assert
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('should return a [UserModel] with the right data', () {
      //Arrange

      //Act
      final result = UserModel.fromJson(tJson);

      //Assert
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('should return a [Map] with the right data', () {
      //Arrange

      //Act
      final result = tModel.toMap();

      //Assert
      expect(result, equals(tMap));
    });
  });
  group('toJson', () {
    test('should return a [JSON String] with the right data', () {
      //Arrange

      //Act
      final result = tModel.toJson();

      final json = jsonEncode({
        "id": "1",
        "name": "_empy.string",
        "avatar": "_empy.string",
        "createdAt": "_empy.string",
      });

      //Assert
      expect(result, equals(json));
    });
  });
}
