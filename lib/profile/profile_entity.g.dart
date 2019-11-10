// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../profile/profile_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return UserProfile(json['firstName'] as String, json['lastName'] as String,
      json['email'] as String, json['birthDay'] as String);
}

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'birthDay': instance.birthDay
    };
