import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:state_management_showcase/util/account_widgets.dart';
import 'package:state_management_showcase/util/app_util.dart';

import 'bloc_complex_login.dart';

class BlocComplexMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseMainScaffold(
      title: 'flutter_bloc',
      description: 'This is a demo of Login flow using the flutter_bloc '
          'library. Just use BlocProvider to inject Bloc, BlocBuilder to '
          'listen for change, and Bloc instance to handle logic.',
      onPressGetStart: () {
        navigateToPage(context, BlocComplexLoginPage());
      },
    );
  }
}
