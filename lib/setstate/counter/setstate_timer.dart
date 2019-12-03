import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:state_management_showcase/util/util_index.dart';

class SetStateTimerPage extends StatefulWidget {
  SetStateTimerPage() {
    Fimber.d('init SetStateTimerPage');
  }

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<SetStateTimerPage> {
  DateTime _now;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('setState - Timer'),
      ),
      body: Center(
        child: TextTimer(value: _now),
      ),
    );
  }
}
