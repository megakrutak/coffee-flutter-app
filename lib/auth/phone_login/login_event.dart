import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class SmsCodeButtonPressed extends LoginEvent {
  final String phone;

  const SmsCodeButtonPressed({
    @required this.phone
  });

  @override
  List<Object> get props => [phone];

  @override
  String toString() =>
      'SmsCodeButtonPressed { phone: $phone }';
}

class LoginButtonPressed extends LoginEvent {
  final String smsCode;

  const LoginButtonPressed({
    @required this.smsCode
  });

  @override
  List<Object> get props => [smsCode];

  @override
  String toString() =>
      'LoginButtonPressed { smsCode: $smsCode }';
}

class ChangePhoneButtonPressed extends LoginEvent {

  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'ChangePhoneButtonPressed {}';
}
