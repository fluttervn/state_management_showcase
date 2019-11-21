import 'package:flutter/material.dart';

class FloatingCounterButtons extends StatelessWidget {
  final VoidCallback onPressIncrease;
  final VoidCallback onPressDecrease;

  const FloatingCounterButtons({
    @required this.onPressIncrease,
    @required this.onPressDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: FloatingActionButton(
            heroTag: 'fab_increase',
            child: Icon(Icons.add),
            onPressed: onPressIncrease,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: FloatingActionButton(
            heroTag: 'fab_decrease',
            child: Icon(Icons.remove),
            onPressed: onPressDecrease,
          ),
        ),
      ],
    );
  }
}

class TextCounter extends StatelessWidget {
  final int number;

  const TextCounter(this.number);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Value is: $number',
      style: TextStyle(fontSize: 24.0),
    );
  }
}
