import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:state_management_showcase/util/app_util.dart';
import 'package:state_management_showcase/util/util_index.dart';

class SetStateComplexHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseHomeScaffold(
      title: 'Homescreen - setState',
      firstContainer: MathContainer(defaultNumber: 3),
      secondContainer: MathContainer(defaultNumber: 25),
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
    if (squareNumber < 0) {
      showToast('Invalid number');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MathContainerBackground(
      children: <Widget>[
        NumberInput(
          defaultNumber: _numInput,
          onValueChanged: (number) {
            _numInput = number;
            _calculateSquareNumber();
          },
        ),
        NumberResult(inputNumber: _numInput, outputNumber: _numOutput),
      ],
    );
  }
}
