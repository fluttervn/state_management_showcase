import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:state_management_showcase/util/util_index.dart';

import 'counter_bloc.dart';

class BlocMultiCounterPage extends StatelessWidget {
  BlocMultiCounterPage() {
    Fimber.d('init BlocMultiCounterPage');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      builder: (context) => CounterBloc(),
      child: _BlocMultiCounterChildPage(),
    );
  }
}

class _BlocMultiCounterChildPage extends StatelessWidget {
  _BlocMultiCounterChildPage() {
    Fimber.d('init _BlocMultiCounterChildPage');
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('flutter_bloc - Counter'),
      ),
      body: TextMultiCounterContainer(
        leftText: BlocBuilder<CounterBloc, int>(
          builder: (context, count) {
            Fimber.d('BlocBuilder: left TextCounter($count)');
            return TextCounter(count, prefix: 'Left:\n');
          },
        ),
        rightText: BlocBuilder<CounterBloc, int>(
          builder: (context, count) {
            Fimber.d('BlocBuilder: right TextCounter($count)');
            return TextCounter(count, prefix: 'Right:\n');
          },
        ),
      ),
      floatingActionButton: FloatingCounterContainer(
        leftFab: FloatingCounterButtons(
          tag: 'left',
          onPressIncrease: () {
            Fimber.d('left: onPressIncrease()');
            counterBloc.add(CounterEvent.increment);
          },
          onPressDecrease: () {
            Fimber.d('left: onPressDecrease()');
            counterBloc.add(CounterEvent.decrement);
          },
        ),
        rightFab: FloatingCounterButtons(
          tag: 'right',
          onPressIncrease: () {
            Fimber.d('right: onPressIncrease()');
            counterBloc.add(CounterEvent.increment);
          },
          onPressDecrease: () {
            Fimber.d('right: onPressDecrease()');
            counterBloc.add(CounterEvent.decrement);
          },
        ),
      ),
    );
  }
}
