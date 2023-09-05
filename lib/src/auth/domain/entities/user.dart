import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? createdAt;
  final String? name;
  final String? avatar;

  const User({
    this.id,
    this.createdAt,
    this.name,
    this.avatar,
  });

  const User.empty()
      : this(
          avatar: '_empy.string',
          createdAt: '_empy.string',
          name: '_empy.string',
          id: '1',
        );

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
