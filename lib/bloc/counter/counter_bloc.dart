import 'package:bloc/bloc.dart';
import 'package:flutter_fimber/flutter_fimber.dart';

enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.decrement:
        Fimber.d('handle CounterEvent.decrement');
        yield state - 1;
        break;
      case CounterEvent.increment:
        Fimber.d('handle CounterEvent.increment');
        yield state + 1;
        break;
    }
  }
}
