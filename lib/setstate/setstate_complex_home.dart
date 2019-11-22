import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:state_management_showcase/util/util_index.dart';

class SetStateComplexHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homescreen - setState'),
      ),
      body: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(height: 10),
          Text('Square Calculator'),
          Text('Please choose a number to calculate its square'),
          MathContainer(defaultNumber: 3),
          Text('... and another Square Calculator'),
          MathContainer(defaultNumber: 25),
        ],
      ),
    );
  }
}

class MathContainer extends StatefulWidget {
  final int defaultNumber;

  const MathContainer({Key key, @required this.defaultNumber})
      : assert(defaultNumber != null),
        super(key: key);

  @override
  _MathContainerState createState() => _MathContainerState();
}

class _MathContainerState extends State<MathContainer> {
  int _numInput;
  int _numOutput;

  CalculatorRepo _repo = CalculatorRepo();

  @override
  void initState() {
    super.initState();
    _numInput = widget.defaultNumber;

    _calculateSquareNumber();
  }

  Future<void> _calculateSquareNumber() async {
    int squareNumber = await _repo.square(_numInput);
    setState(() {
      _numOutput = squareNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            NumberInput(
              defaultNumber: _numInput,
              onValueChanged: (number) {
                _numInput = number;
                _calculateSquareNumber();
              },
            ),
            SizedBox(width: 10),
            Text('Square of $_numInput is $_numOutput'),
          ],
        ),
      ],
    );
  }
}

class NumberInput extends StatefulWidget {
  final int defaultNumber;
  @required
  final ValueChanged<int> onValueChanged;

  NumberInput({
    Key key,
    this.defaultNumber,
    this.onValueChanged,
  }) : super(key: key);

  @override
  _NumberInputState createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  int _number;

  @override
  void initState() {
    super.initState();
    _number = widget.defaultNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                _number--;
              });
              widget.onValueChanged(_number);
            },
            icon: Icon(Icons.maximize),
          ),
          Container(
            width: 30,
            height: 30,
            color: Colors.black12,
            alignment: Alignment.center,
            child: Text('$_number'),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _number++;
              });
              widget.onValueChanged(_number);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
