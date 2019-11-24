import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:state_management_showcase/util/util_index.dart';

class SetStateCounterPage extends StatefulWidget {
  SetStateCounterPage() {
    Fimber.d('init SetStateCounterPage');
  }
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<SetStateCounterPage> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('setState - Counter'),
      ),
      body: Center(
        child: TextCounter(_count),
      ),
      floatingActionButton: FloatingCounterButtons(
        onPressIncrease: () {
          setState(() {
            _count++;
            Fimber.d('increase: count=$_count');
          });
        },
        onPressDecrease: () {
          setState(() {
            _count--;
            Fimber.d('decrease: count=$_count');
          });
        },
      ),
    );
  }
}
