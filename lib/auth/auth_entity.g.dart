// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) {
  return TokenResponse(json['access_token'] as String, json['type'] as String,
      json['refresh_token'] as String);
}

Map<String, dynamic> _$TokenResponseToJson(TokenResponse instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'type': instance.type,
      'refresh_token': instance.refreshToken
    };

Credentials _$CredentialsFromJson(Map<String, dynamic> json) {
  return Credentials(json['login'] as String, json['password'] as String);
}

Map<String, dynamic> _$CredentialsToJson(Credentials instance) =>
    <String, dynamic>{'login': instance.login, 'password': instance.password};

FirebaseUserTokenCheckRequest _$FirebaseUserTokenCheckRequestFromJson(
    Map<String, dynamic> json) {
  return FirebaseUserTokenCheckRequest(json['tokenId'] as String);
}

Map<String, dynamic> _$FirebaseUserTokenCheckRequestToJson(
        FirebaseUserTokenCheckRequest instance) =>
    <String, dynamic>{'tokenId': instance.tokenId};
