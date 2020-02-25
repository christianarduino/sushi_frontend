import 'package:json_annotation/json_annotation.dart';
import 'package:sushi/model/Response/Groups.dart';

part 'User.g.dart';

@JsonSerializable(nullable: true)
class User {
  final String id, name, surname, username, email, password;
  List<Groups> groups;

  User(this.id, this.name, this.surname, this.username, this.email,
      this.password)
      : groups = [];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
