import 'package:json_annotation/json_annotation.dart';

part "SearchGroup.g.dart";

@JsonSerializable()
class SearchGroup {
  final String id, name, description;

  SearchGroup(this.id, this.description, this.name);

  factory SearchGroup.fromJson(Map<String, dynamic> json) =>
      _$SearchGroupFromJson(json);
  Map<String, dynamic> toJson() => _$SearchGroupToJson(this);
}
