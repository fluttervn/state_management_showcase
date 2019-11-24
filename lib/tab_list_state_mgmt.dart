import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:state_management_showcase/bloc/bloc_index.dart';
import 'package:state_management_showcase/setstate/setstate_index.dart';
import 'package:state_management_showcase/util/util_index.dart';

import 'setstate/account/setstate_account_intro.dart';

final Map<String, Widget> mapScreens = {
  'setState - Counter': SetStateCounterPage(),
  'setState - Multi Counter': SetStateMultiCounterPage(),
  'setState - Login': SetStateAccountIntroPage(),
  'flutter_bloc - Counter': BlocCounterPage(),
  'flutter_bloc - Multi Counter': BlocMultiCounterPage(),
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
