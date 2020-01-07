import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class StartTimerEvent extends TimerEvent {
  final int duration;

  StartTimerEvent({@required this.duration});

  @override
  List<Object> get props => [duration];

  @override
  String toString() => "Start { duration: $duration }";
}

class TickEvent extends TimerEvent {
  final int duration;

  TickEvent({@required this.duration});

  @override
  List<Object> get props => [duration];

  @override
  String toString() => "Tick { duration: $duration }";
}
