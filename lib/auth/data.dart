import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class TokenResponse {
  @JsonKey(name: "access_token")
  String accessToken;
  @JsonKey(name: "type")
  String type;
  @JsonKey(name: "refresh_token")
  String refreshToken;

  TokenResponse(this.accessToken, this.type, this.refreshToken);

  factory TokenResponse.fromMappedJson(Map<String, dynamic> json) => _$TokenResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}

@JsonSerializable()
class Credentials {
  @JsonKey(name: "login")
  String login;
  @JsonKey(name: "password")
  String password;

  Credentials(this.login, this.password);

  factory Credentials.fromMappedJson(Map<String, dynamic> json) => _$CredentialsFromJson(json);
  Map<String, dynamic> toJson() => _$CredentialsToJson(this);
}

@JsonSerializable()
class FirebaseUserTokenCheckRequest {
  @JsonKey(name: "tokenId")
  String tokenId;

  FirebaseUserTokenCheckRequest(this.tokenId);

  factory FirebaseUserTokenCheckRequest.fromMappedJson(Map<String, dynamic> json) => _$FirebaseUserTokenCheckRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FirebaseUserTokenCheckRequestToJson(this);
}