import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class SmsCodeTimerBloc extends Bloc<SmsCodeTimerEvent, SmsCodeTimerState> {
  final int duration = 60;
  final Ticker _ticker;

  StreamSubscription<int> _tickerSubscription;

  SmsCodeTimerBloc({@required Ticker ticker})
    : assert(ticker != null), _ticker = ticker;

  @override
  SmsCodeTimerState get initialState => InitialSmsCodeTimerState(duration);

  @override
  Stream<SmsCodeTimerState> mapEventToState(SmsCodeTimerEvent event) async* {
    if (event is StartSmsCodeTimerEvent) {
      yield* _mapStartToState(event);
    } else if (event is TickSmsCodeTimerEvent) {
      yield* _mapTickToState(event);
    }
  }

  Stream<SmsCodeTimerState> _mapStartToState(StartSmsCodeTimerEvent start) async* {
     yield RunningSmsCodeTimerState(start.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: start.duration)
        .listen((duration) => add(TickSmsCodeTimerEvent(duration: duration)));
  }

  Stream<SmsCodeTimerState> _mapTickToState(TickSmsCodeTimerEvent tick) async* {
    yield tick.duration > 0 ? RunningSmsCodeTimerState(tick.duration) : InitialSmsCodeTimerState(this.duration);
  }
}
