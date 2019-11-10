
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:robo_coffee_app/profile/profile_event.dart';
import 'package:robo_coffee_app/profile/profile_repo.dart';
import 'package:robo_coffee_app/profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepo;

  ProfileBloc({@required this.profileRepo}) : assert(profileRepo != null);

  @override
  ProfileState get initialState => ProfileLoading();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is LoadProfile) {
      yield ProfileLoading();
      var profile = await profileRepo.getProfile();
      yield ProfileLoaded(profile: profile);
    }

    if (event is UpdateProfile) {
      yield ProfileLoading();
      var profile = await profileRepo.updateProfile(event.profile);
      yield ProfileLoaded(profile: profile);
    }
  }

}