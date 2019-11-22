import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_showcase/util/base_simple.dart';

import 'counter_bloc.dart';

class BlocSimpleMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      builder: (context) => CounterBloc(),
      child: _BlocSimpleChildPage(),
    );
  }
}

class _BlocSimpleChildPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('flutter_bloc - simple'),
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, int>(
          builder: (context, count) {
            return TextCounter(count);
          },
        ),
      ),
      floatingActionButton: FloatingCounterButtons(
        onPressIncrease: () {
          counterBloc.add(CounterEvent.increment);
        },
        onPressDecrease: () {
          counterBloc.add(CounterEvent.decrement);
        },
      ),
    );
  }
}
