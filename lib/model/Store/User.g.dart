// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as String,
    json['name'] as String,
    json['surname'] as String,
    json['username'] as String,
    json['email'] as String,
    json['password'] as String,
    (json['groups'] as List)
        ?.map((e) =>
            e == null ? null : UserGroup.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'groups': instance.groups,
    };

UserGroup _$UserGroupFromJson(Map<String, dynamic> json) {
  return UserGroup(
    json['isAdmin'] as bool,
    json['groupId'] as String,
  );
}

Map<String, dynamic> _$UserGroupToJson(UserGroup instance) => <String, dynamic>{
      'isAdmin': instance.isAdmin,
      'groupId': instance.groupId,
    };
