import 'package:bloc_counter/logic/cubit/counter_cubit.dart';
import 'package:bloc_counter/logic/cubit/internet_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final CounterState counterState1 = CounterState(counterValue: 1);
  final CounterState counterState2 = CounterState(counterValue: 1);
  group('CounterCubit', () {
    Connectivity? connectivity;
    CounterCubit? counterCubit;
    InternetCubit? internetCubit;

    //initialize the necessary data
    setUp(() => {
          connectivity = Connectivity(),
          internetCubit = InternetCubit(connectivity: connectivity!),
          counterCubit = CounterCubit(internetCubit: internetCubit!),
        });
    // it will apply only in the group
    tearDown(() => counterCubit?.close());

    test('the initial state for the Counter is CounterState(counterValue: 0)', () {
      expect(counterCubit?.state.counterValue, CounterState(counterValue: 0).counterValue);
    });

    //type params must be the cubit,bloc and the state class
    blocTest<CounterCubit, CounterState>(
      'emits [] when nothing is called',
      build: () => counterCubit!,
      expect: () => const <int>[],
    );

    blocTest<CounterCubit, CounterState>('emits [1] when increment is called',
        build: () => counterCubit!,
        act: (cubit) => cubit.increment(),
        expect: () => [CounterState(counterValue: 1, wasIncremented: true)]);

    blocTest<CounterCubit, CounterState>(
      'emits [] when nothing is called',
      build: () => counterCubit!,
      expect: () => const <int>[],
    );

    //decrement function test
    blocTest<CounterCubit, CounterState>('emits [-1] when decrement is called',
        build: () => counterCubit!,
        act: (cubit) => cubit.decrement(),
        expect: () => [CounterState(counterValue: -1, wasIncremented: true)]);
  });
}
