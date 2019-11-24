import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:state_management_showcase/bloc/bloc_complex_login.dart';
import 'package:state_management_showcase/bloc/bloc_simple_main.dart';
import 'package:state_management_showcase/setstate/setstate_counter_main.dart';
import 'package:state_management_showcase/util/app_util.dart';

import 'setstate/account/setstate_account_intro.dart';

final Map<String, Widget> mapScreens = {
  'setState - Counter': SetStateCounterMainPage(),
  'setState - Login': SetStateAccountIntroPage(),
  'flutter_bloc - simple': BlocSimpleMainPage(),
  'flutter_bloc - complex': BlocComplexLoginPage(),
};

class ListStateManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(10),
      itemCount: mapScreens.length,
      itemBuilder: (context, index) {
        final title = mapScreens.keys.elementAt(index);
        return ListTile(
          title: Text(title),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            navigateToPage(context, mapScreens[title]);
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
