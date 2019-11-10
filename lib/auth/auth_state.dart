import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:robo_coffee_app/profile/profile_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthUninitialized extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserProfile profile;

  const AuthAuthenticated({@required this.profile}) : assert(profile != null);

  @override
  List<Object> get props => [profile];

  @override
  String toString() => 'AuthAuthenticated { profile: $profile }';
}