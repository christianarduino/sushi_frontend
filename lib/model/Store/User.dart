import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable(nullable: true)
class User {
  final String id, name, surname, username, email, password;
  List<UserGroup> groups;

  User(this.id, this.name, this.surname, this.username, this.email,
      this.password, this.groups);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class UserGroup {
  bool isAdmin;
  String groupId;

  UserGroup(this.isAdmin, this.groupId);

  factory UserGroup.fromJson(Map<String, dynamic> json) =>
      _$UserGroupFromJson(json);
  Map<String, dynamic> toJson() => _$UserGroupToJson(this);
}
