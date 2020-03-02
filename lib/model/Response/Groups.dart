import 'package:json_annotation/json_annotation.dart';

part 'Groups.g.dart';

@JsonSerializable()
class Groups {
  List<Group> admin;
  List<Group> member;

  Groups(this.admin, this.member);

  factory Groups.fromJson(Map<String, dynamic> json) => _$GroupsFromJson(json);
  Map<String, dynamic> toJson() => _$GroupsToJson(this);
}

@JsonSerializable()
class Group {
  String id, name, description;
  bool isAdmin;

  Group(this.id, this.name, this.description, this.isAdmin);

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
