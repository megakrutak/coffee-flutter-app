import 'package:json_annotation/json_annotation.dart';
import 'package:robo_coffee_app/base/json_encodable.dart';

part 'auth_entity.g.dart';

@JsonSerializable()
class TokenResponse implements JsonEncodable {
  @JsonKey(name: "access_token")
  String accessToken;
  @JsonKey(name: "token_type")
  String type;
  @JsonKey(name: "refresh_token")
  String refreshToken;

  TokenResponse(this.accessToken, this.type, this.refreshToken);

  factory TokenResponse.fromJson(Map<String, dynamic> json) => _$TokenResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}

@JsonSerializable()
class Credentials implements JsonEncodable {
  @JsonKey(name: "login")
  String login;
  @JsonKey(name: "password")
  String password;

  Credentials(this.login, this.password);

  factory Credentials.fromJson(Map<String, dynamic> json) => _$CredentialsFromJson(json);
  Map<String, dynamic> toJson() => _$CredentialsToJson(this);
}

@JsonSerializable()
class FirebaseUserTokenCheckRequest implements JsonEncodable {
  @JsonKey(name: "tokenId")
  String tokenId;

  FirebaseUserTokenCheckRequest(this.tokenId);

  factory FirebaseUserTokenCheckRequest.fromJson(Map<String, dynamic> json) => _$FirebaseUserTokenCheckRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FirebaseUserTokenCheckRequestToJson(this);
}