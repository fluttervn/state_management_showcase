import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:state_management_showcase/util/util_index.dart';

import 'setstate_account_login.dart';

class SetStateAccountIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseMainScaffold(
      title: 'setState',
      description: 'This is a demo of Login flow using the built-in setState() '
          'of Flutter. Just set the value inside setState() method, then the '
          'whole widget will be rebuilt with new value.',
      onPressGetStart: () {
        navigateToPage(context, SetStateAccountLoginPage());
      },
    );
  }
}
