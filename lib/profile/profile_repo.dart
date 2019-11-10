
import 'package:robo_coffee_app/profile/profile_entity.dart';

abstract class ProfileRepository {
  Future<UserProfile> getProfile({bool fromCache = false});
  Future<UserProfile> updateProfile(UserProfile profile);
}

class FakeProfileRepositoryImpl implements ProfileRepository{
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