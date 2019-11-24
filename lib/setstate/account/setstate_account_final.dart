import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:state_management_showcase/util/util_index.dart';

class SetStateAccountFinalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseHomeScaffold(
      title: 'Final screen - setState',
      firstContainer: _MathContainer(defaultNumber: 3),
      secondContainer: _MathContainer(defaultNumber: 25),
    );
  }
}

class _MathContainer extends StatefulWidget {
  final int defaultNumber;

  // ignore: always_put_required_named_parameters_first
  const _MathContainer({Key key, @required this.defaultNumber})
      : assert(defaultNumber != null),
        super(key: key);

  @override
  _MathContainerState createState() => _MathContainerState();
}

class _MathContainerState extends State<_MathContainer> {
  int _numInput;
  int _numOutput;

  AppRepo repo = AppRepo();
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
