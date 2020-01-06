import 'package:equatable/equatable.dart';

abstract class SmsCodeTimerState extends Equatable {
  const SmsCodeTimerState();

  @override
  List<Object> get props => [];
}

class InitialSmsCodeTimerState extends SmsCodeTimerState {

  @override
  String toString() => 'Initial { }';
}

class RunningSmsCodeTimerState extends SmsCodeTimerState {
  final int duration;

  RunningSmsCodeTimerState(this.duration) : super();

  @override
  String toString() => 'Running { duration: $duration }';
}
