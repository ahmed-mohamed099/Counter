import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_state.dart';
import 'counter_storage.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit()
      : super(
    CounterState(
      counter: CounterStorage.getCounter(),
    ),
  );

  Future<void> increment() async {
    final newValue = state.counter + 1;
    await CounterStorage.saveCounter(newValue);
    emit(CounterState(counter: newValue));
  }

  Future<void> decrement() async {
    final newValue = state.counter - 1;
    await CounterStorage.saveCounter(newValue);
    emit(CounterState(counter: newValue));
  }
}