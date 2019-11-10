
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:robo_coffee_app/profile/profile_entity.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final UserProfile profile;

  UpdateProfile({@required this.profile}) : assert(profile != null);

  @override
  List<Object> get props => [profile];

  @override
  String toString() => 'UpdateProfile { profile: $profile }';
}


