// import 'dart:async';

// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'ticker.dart';

// part 'timer_event.dart';
// part 'timer_state.dart';

// class TimerBloc extends Bloc<TimerEvent, TimerState> {
//   final Ticker _ticker;
//   static const int _duration = 59;

//   StreamSubscription<int>? _tickerSubscription;

//   @override
//   Future<void> close() {
//     _tickerSubscription?.cancel();
//     return super.close();
//   }

//   TimerBloc({required Ticker ticker})
//     : _ticker = ticker,
//       super(const TimerInitialState(59)) {
//     on<StartTimerEvent>(_onStarted);
//     on<ResetTimerEvent>(_onReset);
//     on<TimerTickedEvent>(_onTicked);
//   }

//   void _onStarted(StartTimerEvent event, Emitter<TimerState> emit) {
//     emit(TimerRunningState(event.duration));
//     _tickerSubscription?.cancel();
//     _tickerSubscription = _ticker
//         .tick(ticks: event.duration)
//         .listen((duration) => add(TimerTickedEvent(duration: duration)));
//   }

//   void _onReset(ResetTimerEvent event, Emitter<TimerState> emit) {
//     _tickerSubscription?.cancel();
//     emit(const TimerInitialState(_duration));
//   }

//   void _onTicked(TimerTickedEvent event, Emitter<TimerState> emit) {
//     emit(
//       event.duration > 0
//           ? TimerRunningState(event.duration)
//           : const TimerRunComplete(),
//     );
//   }
// }
