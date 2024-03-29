import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:state_management_showcase/util/util_index.dart';

import 'counter_bloc.dart';

class BlocMultiCounterPage extends StatelessWidget {
  MultiCounterBloc _leftBloc;
  MultiCounterBloc _rightBloc;

  BlocMultiCounterPage() {
    Fimber.d('init BlocMultiCounterPage');
    _leftBloc = MultiCounterBloc();
    _rightBloc = MultiCounterBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter_bloc - Counter'),
      ),
      body: TextMultiCounterContainer(
        leftText: BlocBuilder<MultiCounterBloc, MultiCounterState>(
          bloc: _leftBloc,
          condition: (prevState, state) {
            // Only allow state from left FAB
            return state.isFromLeft;
          },
          builder: (context, state) {
            Fimber.d('BlocBuilder: left TextCounter(${state.count})');
            return TextCounter(state.count, prefix: 'Left:\n');
          },
        ),
        rightText: BlocBuilder<MultiCounterBloc, MultiCounterState>(
          bloc: _rightBloc,
          condition: (prevState, state) {
            // Only allow state from right FAB
            return !state.isFromLeft;
          },
          builder: (context, state) {
            Fimber.d('BlocBuilder: right TextCounter(${state.count})');
            return TextCounter(state.count, prefix: 'Right:\n');
          },
        ),
      ),
      floatingActionButton: FloatingCounterContainer(
        leftFab: FloatingCounterButtons(
          tag: 'left',
          onPressIncrease: () {
            Fimber.d('left: onPressIncrease()');
            _leftBloc.add(MultiCounterEvent.increaseLeft);
          },
          onPressDecrease: () {
            Fimber.d('left: onPressDecrease()');
            _leftBloc.add(MultiCounterEvent.decreaseLeft);
          },
        ),
        rightFab: FloatingCounterButtons(
          tag: 'right',
          onPressIncrease: () {
            Fimber.d('right: onPressIncrease()');
            _rightBloc.add(MultiCounterEvent.increaseRight);
          },
          onPressDecrease: () {
            Fimber.d('right: onPressDecrease()');
            _rightBloc.add(MultiCounterEvent.decreaseRight);
          },
        ),
      ),
    );
  }
}
