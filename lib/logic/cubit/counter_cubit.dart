import 'dart:async';

import 'package:bloc_counter/constants/enum.dart';
import 'package:bloc_counter/logic/cubit/internet_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'internet_cubit.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  //dependent on the internet cubit
  final InternetCubit internetCubit;
  StreamSubscription? internetStreamSubscription;

  CounterCubit({required this.internetCubit}) : super(CounterState(counterValue: 0)) {
    monitorInternetCubit();
  }

  void monitorInternetCubit() {
     internetStreamSubscription = internetCubit.stream.listen((internetState) {
      if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.Wifi) {
        increment();
      } else if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.Mobile) {
        decrement();
      }
    });
  }

  void increment() =>
      emit(CounterState(counterValue: state.counterValue + 1, wasIncremented: true));

  void decrement() =>
      emit(CounterState(counterValue: state.counterValue - 1, wasIncremented: true));

  void resetCounter() => emit(CounterState(counterValue: 0));

  // we need to close the stream
  @override
  Future<void> close() {
    internetStreamSubscription?.cancel();
    return super.close();
  }
}
