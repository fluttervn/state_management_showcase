import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:state_management_showcase/util/base_simple.dart';

class SetStateCounterPage extends StatefulWidget {
  final String tag = 'SetStateCounterPage';

  SetStateCounterPage() {
    print('$tag: init');
  }
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<SetStateCounterPage> {
  final String tag = '_CounterPageState';

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
            print('$tag: increase: count=$_count');
          });
        },
        onPressDecrease: () {
          setState(() {
            _count--;
            print('$tag: decrease: count=$_count');
          });
        },
      ),
    );
  }
}