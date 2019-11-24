import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:state_management_showcase/util/util_index.dart';

import 'counter_bloc.dart';

class BlocCounterPage extends StatelessWidget {
  BlocCounterPage() {
    Fimber.d('init BlocCounterPage');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      builder: (context) => CounterBloc(),
      child: _BlocCounterChildPage(),
    );
  }
}

class _BlocCounterChildPage extends StatelessWidget {
  _BlocCounterChildPage() {
    Fimber.d('init _BlocCounterChildPage');
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('flutter_bloc - Counter'),
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, int>(
          builder: (context, count) {
            Fimber.d('BlocBuilder: TextCounter($count)');
            return TextCounter(count);
          },
        ),
      ),
      floatingActionButton: FloatingCounterButtons(
        onPressIncrease: () {
          Fimber.d('onPressIncrease()');
          counterBloc.add(CounterEvent.increment);
        },
        onPressDecrease: () {
          Fimber.d('onPressDecrease()');
          counterBloc.add(CounterEvent.decrement);
        },
      ),
    );
  }
}
