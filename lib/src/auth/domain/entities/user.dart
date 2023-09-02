import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? createdAt;
  final String? name;
  final String? avatar;

  const User({
    this.id,
    this.createdAt,
    this.name,
    this.avatar,
  });

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.name == name &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return id.hashCode ^ createdAt.hashCode ^ name.hashCode ^ avatar.hashCode;
  }

  @override
  List<Object> get props => [id!, createdAt!, name!, avatar!];
}
