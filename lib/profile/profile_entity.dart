import 'package:json_annotation/json_annotation.dart';
import 'package:robo_coffee_app/base/json_encodable.dart';

part 'profile_entity.g.dart';

@JsonSerializable()
class UserProfile implements JsonEncodable {

  @JsonKey(name: "firstName")
  String firstName;
  @JsonKey(name: "lastName")
  String lastName;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "birthDay")
  String birthDay;

  UserProfile(this.firstName, this.lastName, this.email, this.birthDay);

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}