import 'dart:convert';

import '../../../../core/utils/typedef.dart';
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.avatar,
    required super.createdAt,
  });

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  const UserModel.empty()
      : this(
          avatar: '_empy.string',
          createdAt: '_empy.string',
          name: '_empy.string',
          id: '1',
        );

  UserModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          name: map['name'] as String,
          avatar: map['avatar'] as String,
          createdAt: map['createdAt'] as String,
        );

  UserModel copyWith({
    String? avatar,
    String? name,
    String? createdAt,
    String? id,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  DataMap toMap() => {
        'id': id,
        'name': name,
        'avatar': avatar,
        'createdAt': createdAt,
      };

  String toJson() => jsonEncode(toMap());
}
