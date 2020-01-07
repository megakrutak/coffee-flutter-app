import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class SmsCodeTimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;

  StreamSubscription<int> _tickerSubscription;

  SmsCodeTimerBloc({@required Ticker ticker})
    : assert(ticker != null), _ticker = ticker;

  @override
  TimerState get initialState => Ready();

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if (event is StartTimerEvent) {
      yield* _mapStartToState(event);
    } else if (event is TickEvent) {
      yield* _mapTickToState(event);
    }
  }

  Stream<TimerState> _mapStartToState(StartTimerEvent start) async* {
     yield Running(start.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: start.duration)
        .listen((duration) => add(TickEvent(duration: duration)));
  }

  Stream<TimerState> _mapTickToState(TickEvent tick) async* {
    yield tick.duration > 0 ? Running(tick.duration) : Ready();
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    super.close();
  }
}
