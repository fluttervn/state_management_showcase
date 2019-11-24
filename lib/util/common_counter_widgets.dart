import 'package:flutter/material.dart';

class FloatingCounterContainer extends StatelessWidget {
  final FloatingCounterButtons leftFab;
  final FloatingCounterButtons rightFab;

  const FloatingCounterContainer({
    @required this.leftFab,
    @required this.rightFab,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 31),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: leftFab,
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: rightFab,
        ),
      ],
    );
  }
}

class FloatingCounterButtons extends StatelessWidget {
  final String tag;
  final VoidCallback onPressIncrease;
  final VoidCallback onPressDecrease;

  const FloatingCounterButtons({
    @required this.onPressIncrease,
    @required this.onPressDecrease,
    this.tag = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: FloatingActionButton(
            heroTag: '${tag}_fab_increase',
            onPressed: onPressIncrease,
            child: Icon(Icons.add),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: FloatingActionButton(
            heroTag: '${tag}_fab_decrease',
            onPressed: onPressDecrease,
            child: Icon(Icons.remove),
          ),
        ),
      ],
    );
  }
}

class TextMultiCounterContainer extends StatelessWidget {
  final Widget leftText;
  final Widget rightText;

  const TextMultiCounterContainer({
    @required this.leftText,
    @required this.rightText,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: leftText,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: rightText,
            ),
          ),
        ],
      ),
    );
  }
}

class TextCounter extends StatelessWidget {
  final int number;
  final String prefix;

  const TextCounter(this.number, {this.prefix = ''});

  @override
  Widget build(BuildContext context) {
    String text = 'Value is: $number';
    if (prefix != null && prefix.isNotEmpty) {
      text = '$prefix$text';
    }
    return Text(text, style: TextStyle(fontSize: 24));
  }
}
