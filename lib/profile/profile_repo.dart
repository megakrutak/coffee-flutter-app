
import 'package:robo_coffee_app/cache/cache.dart';
import 'package:robo_coffee_app/profile/profile_api.dart';
import 'package:robo_coffee_app/profile/profile_entity.dart';

abstract class ProfileRepository {
  Future<UserProfile> getProfile({bool fromCache = false});
  Future<UserProfile> updateProfile(UserProfile profile);
}

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileApi _profileApi;
  CacheManager _cache;

  ProfileRepositoryImpl(this._profileApi, this._cache);

  @override
  Future<UserProfile> getProfile({bool fromCache = false}) async {
    if (fromCache) {
      var profileMap = await _cache.read<UserProfile>();
      if (profileMap != null) {
        return UserProfile.fromJson(profileMap);
      }
    }
    return _getProfileFromServerAndSave();
  }

  Future<UserProfile> _getProfileFromServerAndSave() async {
    var profile = await _profileApi.getPersonalData();
    await _cache.write(profile);
    return profile;
  }

  @override
  Future<UserProfile> updateProfile(UserProfile profile) {
    return _profileApi.updatePersonalData(profile);
  }
}

class FakeProfileRepositoryImpl implements ProfileRepository {

  @override
  Future<UserProfile> getProfile({bool fromCache = false}) {
    return Future.delayed(Duration(seconds: 3), () {
      return UserProfile("Василий", "Пупкин", "asdgd@fhfgh.ru", "24.08.1989");
    });
  }

  @override
  Future<UserProfile> updateProfile(UserProfile profile) {
    return Future.delayed(Duration(seconds: 3), () {
      return profile;
    });
  }
}