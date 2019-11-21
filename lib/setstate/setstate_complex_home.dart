import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:state_management_showcase/util/base_complex.dart';
import 'package:state_management_showcase/util/util_index.dart';

ExpectedResult _expectedResult = ExpectedResult.success;

class SetStateComplexHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithToggle(
        title: 'Homescreen - setState',
        onChanged: (ExpectedResult value) {
          _expectedResult = value;
        },
      ),
      body: Center(
        child: Text('Login successfully'),
      ),
    );
  }
}
