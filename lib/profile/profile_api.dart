import 'dart:convert';

import 'package:robo_coffee_app/base/http.dart';
import 'package:robo_coffee_app/profile/profile_entity.dart';

abstract class ProfileApi {
  Future<UserProfile> getPersonalData();
  Future<UserProfile> updatePersonalData(UserProfile profile);
}

class RemoteProfileApi extends ProfileApi {
  RestApiHttpClient _httpClient;

  RemoteProfileApi(this._httpClient);

  @override
  Future<UserProfile> getPersonalData() async {
    var response = await _httpClient.get('/api/v1/personal_data');
    return UserProfile.fromJson(json.decode(response.body));
  }

  @override
  Future<UserProfile> updatePersonalData(UserProfile profile) async {
    var response = await _httpClient.put('/api/v1/personal_data/update', body: json.encode(profile.toJson()));
    return UserProfile.fromJson(json.decode(response.body));
  }

}