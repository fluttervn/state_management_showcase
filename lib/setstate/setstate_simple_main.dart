import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:state_management_showcase/util/base_simple.dart';

class SetStateSimpleMainPage extends StatefulWidget {
  @override
  _SetStateSimpleMainPageState createState() => _SetStateSimpleMainPageState();
}

class _SetStateSimpleMainPageState extends State<SetStateSimpleMainPage> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('setState - simple'),
      ),
      body: Center(
        child: TextCounter(_count),
      ),
      floatingActionButton: FloatingCounterButtons(
        onPressIncrease: () {
          setState(() {
            _count++;
          });
        },
        onPressDecrease: () {
          setState(() {
            _count--;
          });
        },
      ),
    );
  }
}
