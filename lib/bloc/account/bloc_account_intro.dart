import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:state_management_showcase/util/util_index.dart';

class BlocAccountIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseMainScaffold(
      title: 'flutter_bloc',
      description: 'This is a demo of Login flow using the well-known '
          'flutter_bloc.',
      onPressGetStart: () {
        // navigateToPage(context, SetStateAccountLoginPage());
      },
    );
  }
}
