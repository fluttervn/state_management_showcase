import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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

enum MultiCounterEvent {
  increaseLeft,
  decreaseLeft,
  increaseRight,
  decreaseRight
}

class MultiCounterState extends Equatable {
  final int count;
  final bool isFromLeft;

  const MultiCounterState(this.count, this.isFromLeft);

  @override
  List<Object> get props => [count, isFromLeft];

  @override
  String toString() {
    return 'MultiCounterState{count: $count, isFromLeft: $isFromLeft}';
  }
}

class MultiCounterBloc extends Bloc<MultiCounterEvent, MultiCounterState> {
  @override
  MultiCounterState get initialState => MultiCounterState(0, false);

  @override
  Stream<MultiCounterState> mapEventToState(MultiCounterEvent event) async* {
    switch (event) {
      case MultiCounterEvent.increaseLeft:
        var _state = MultiCounterState(state.count + 1, true);
        Fimber.d('increaseLeft => $_state from $state');
        yield _state;
        break;
      case MultiCounterEvent.decreaseLeft:
        var _state = MultiCounterState(state.count - 1, true);
        Fimber.d('decreaseLeft => $_state from $state');
        yield _state;
        break;
      case MultiCounterEvent.increaseRight:
        var _state = MultiCounterState(state.count + 1, false);
        Fimber.d('increaseRight => $_state from $state');
        yield _state;
        break;
      case MultiCounterEvent.decreaseRight:
        var _state = MultiCounterState(state.count - 1, false);
        Fimber.d('decreaseRight => $_state from $state');
        yield _state;
        break;
    }
  }
}
