import 'package:equatable/equatable.dart';

abstract class SmsCodeTimerState extends Equatable {
  final int duration;
  const SmsCodeTimerState(this.duration);

  @override
  List<Object> get props => [];
}

class InitialSmsCodeTimerState extends SmsCodeTimerState {

  InitialSmsCodeTimerState(int duration) : super(duration);

  @override
  String toString() => 'Ready { duration: $duration }';
}

class RunningSmsCodeTimerState extends SmsCodeTimerState {

  RunningSmsCodeTimerState(int duration) : super(duration);

  @override
  String toString() => 'Running { duration: $duration }';
}
