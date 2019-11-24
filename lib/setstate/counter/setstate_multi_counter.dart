import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:state_management_showcase/util/util_index.dart';

class SetStateMultiCounterPage extends StatefulWidget {
  final String tag = 'SetStateMultiCounterPage';

  SetStateMultiCounterPage() {
    print('$tag: init');
  }
  @override
  _MultiCounterPageState createState() => _MultiCounterPageState();
}

class _MultiCounterPageState extends State<SetStateMultiCounterPage> {
  final String tag = '_MultiCounterPageState';
  int _countRight = 0;
  int _countLeft = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('setState - Multi Counter'),
      ),
      body: TextMultiCounterContainer(
        leftText: TextCounter(_countLeft, prefix: 'Left:\n'),
        rightText: TextCounter(_countRight, prefix: 'Right:\n'),
      ),
      floatingActionButton: FloatingCounterContainer(
        leftFab: FloatingCounterButtons(
          tag: 'left',
          onPressIncrease: () {
            setState(() {
              _countLeft++;
              print('$tag: left: increase to $_countLeft');
            });
          },
          onPressDecrease: () {
            setState(() {
              _countLeft--;
              print('$tag: left: decrease to $_countLeft');
            });
          },
        ),
        rightFab: FloatingCounterButtons(
          tag: 'right',
          onPressIncrease: () {
            setState(() {
              _countRight++;
              print('$tag: right: increase to $_countRight');
            });
          },
          onPressDecrease: () {
            setState(() {
              _countRight--;
              print('$tag: right: decrease to $_countRight');
            });
          },
        ),
      ),
    );
  }
}
