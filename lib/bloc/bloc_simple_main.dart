import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:state_management_showcase/util/base_simple.dart';

class BlocSimpleMainPage extends StatefulWidget {
  @override
  _BlocSimpleMainPageState createState() => _BlocSimpleMainPageState();
}

class _BlocSimpleMainPageState extends State<BlocSimpleMainPage> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter_bloc - simple'),
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
