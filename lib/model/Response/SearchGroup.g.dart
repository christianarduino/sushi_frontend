// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SearchGroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchGroup _$SearchGroupFromJson(Map<String, dynamic> json) {
  return SearchGroup(
    json['id'] as String,
    json['description'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$SearchGroupToJson(SearchGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
