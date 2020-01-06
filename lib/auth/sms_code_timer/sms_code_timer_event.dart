import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SmsCodeTimerEvent extends Equatable {
  const SmsCodeTimerEvent();

  @override
  List<Object> get props => [];
}

class StartSmsCodeTimerEvent extends SmsCodeTimerEvent {
  final int duration;

  StartSmsCodeTimerEvent({@required this.duration});

  @override
  String toString() => "Start { duration: $duration }";
}

class TickSmsCodeTimerEvent extends SmsCodeTimerEvent {
  final int duration;

  TickSmsCodeTimerEvent({@required this.duration});

  @override
  List<Object> get props => [duration];

  @override
  String toString() => "Start { duration: $duration }";
}
