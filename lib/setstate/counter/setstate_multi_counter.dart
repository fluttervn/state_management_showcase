import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:state_management_showcase/util/util_index.dart';

class SetStateMultiCounterMainPage extends StatefulWidget {
  @override
  _MultiCounterMainPageState createState() => _MultiCounterMainPageState();
}

class _MultiCounterMainPageState extends State<SetStateMultiCounterMainPage> {
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
            });
          },
          onPressDecrease: () {
            setState(() {
              _countLeft--;
            });
          },
        ),
        rightFab: FloatingCounterButtons(
          tag: 'right',
          onPressIncrease: () {
            setState(() {
              _countRight++;
            });
          },
          onPressDecrease: () {
            setState(() {
              _countRight--;
            });
          },
        ),
      ),
    );
  }
}
