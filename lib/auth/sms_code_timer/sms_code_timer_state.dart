import 'package:equatable/equatable.dart';

abstract class TimerState extends Equatable {
  const TimerState();

  @override
  List<Object> get props => [];
}

class Ready extends TimerState {

  @override
  String toString() => 'Ready { }';
}

class Running extends TimerState {
  final int duration;

  Running(this.duration) : super();

  @override
  List<Object> get props => [duration];

  @override
  String toString() => 'Running { duration: $duration }';
}
