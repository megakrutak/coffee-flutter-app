
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:robo_coffee_app/profile/profile_entity.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfile profile;

  const ProfileLoaded({@required this.profile}) : assert(profile != null);

  @override
  List<Object> get props => [profile];

  @override
  String toString() => 'ProfileLoaded { profile: $profile }';
}
