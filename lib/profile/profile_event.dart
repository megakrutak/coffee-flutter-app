
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:robo_coffee_app/profile/profile_entity.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final UserProfile profile;

  UpdateProfileEvent({@required this.profile}) : assert(profile != null);

  @override
  List<Object> get props => [profile];

  @override
  String toString() => 'UpdateProfile { profile: $profile }';
}


