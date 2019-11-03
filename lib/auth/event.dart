import 'package:coffee_flutter_app/auth/data.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class PhoneSended extends AuthEvent {
  final String phone;

  const PhoneSended({@required this.phone});

  @override
  List<Object> get props => [phone];

  @override
  String toString() => 'PhoneSended { phone: $phone }';
}

/*class AuthCodeSended extends AuthEvent {
  final String authCode;

  const AuthCodeSended({@required this.authCode});

  @override
  List<Object> get props => [authCode];

  @override
  String toString() => 'AuthCodeSended { authCode: $authCode }';
}*/

class LoggedIn extends AuthEvent {
  final TokenResponse token;

  const LoggedIn({@required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoggedIn { token: $token }';
}

class LoggedOut extends AuthEvent {}