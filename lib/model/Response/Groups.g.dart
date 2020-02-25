// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Groups.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Groups _$GroupsFromJson(Map<String, dynamic> json) {
  return Groups(
    (json['admin'] as List)
        ?.map(
            (e) => e == null ? null : Group.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['member'] as List)
        ?.map(
            (e) => e == null ? null : Group.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GroupsToJson(Groups instance) => <String, dynamic>{
      'admin': instance.admin,
      'member': instance.member,
    };

Group _$GroupFromJson(Map<String, dynamic> json) {
  return Group(
    json['id'] as String,
    json['name'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
