
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
  final String phone;

  const ProfileLoaded({@required this.profile, @required this.phone}) : assert(profile != null && phone != null);

  @override
  List<Object> get props => [profile, phone];

  @override
  String toString() => 'ProfileLoaded { profile: $profile phone: $phone}';
}

class ProfileUpdated extends ProfileState {
  final UserProfile profile;
  final String phone;

  const ProfileUpdated({@required this.profile, @required this.phone}) : assert(profile != null && phone != null);

  @override
  List<Object> get props => [profile, phone];

  @override
  String toString() => 'ProfileUpdated { profile: $profile phone: $phone}';
}
