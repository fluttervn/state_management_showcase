import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_repo.dart';
import 'app_util.dart';

class BaseMainScaffold extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onPressGetStart;

  const BaseMainScaffold({
    Key key,
    this.title,
    this.description,
    this.onPressGetStart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(title),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/state_mgmt_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(48),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.deepOrange.shade700,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 30.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                      elevation: 0,
                      highlightElevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: onPressGetStart,
                      child: Text(
                        'Get started',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InputUsernameFormContainer extends StatelessWidget {
  final List<Widget> children;

  const InputUsernameFormContainer({Key key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: children,
      ),
    );
  }
}

class UsernameTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final bool showError;
  final String initText;

  const UsernameTextField({
    Key key,
    this.showError,
    this.initText,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String errorText;
    if (true == showError) {
      errorText = 'Username must have $usernameMinLength - '
          '$usernameMaxLength char';
    }

    return Container(
      height: 90,
      child: TextFormField(
        initialValue: initText,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          prefixIcon: Icon(Icons.person),
          labelText: 'Username',
          hintText: 'Username must have $usernameMinLength - '
              '$usernameMaxLength char',
          errorText: errorText,
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final bool showError;

  const PasswordTextField({
    Key key,
    this.showError,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String errorText;
    if (true == showError) {
      errorText = 'Password must have $passwordMaxLength - '
          '$passwordMaxLength char';
    }

    return Container(
      height: 90,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          prefixIcon: Icon(Icons.vpn_key),
          labelText: 'Password',
          hintText: 'Password must have $passwordMaxLength - '
              '$passwordMaxLength char',
          errorText: errorText,
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class ButtonLoginWithUsername extends StatelessWidget {
  final String text;
  final bool isEnable;
  final bool isLoading;
  @required
  final VoidCallback onPressed;

  const ButtonLoginWithUsername({
    Key key,
    @required this.text,
    this.isEnable,
    this.isLoading,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = isLoading ? 'Loading...' : text;
    bool isButtonEnable = !isLoading && isEnable;
    return RaisedButton(
      onPressed: isButtonEnable ? onPressed : null,
      child: Text(title),
    );
  }
}

class ButtonResetName extends StatelessWidget {
  @required
  final VoidCallback onPressed;

  const ButtonResetName({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Text(
        'If you forgot username, click here \n'
        'to get new email to login again.',
        style: TextStyle(fontWeight: FontWeight.normal),
      ),
    );
  }
}

class AppBarWithToggle extends StatefulWidget implements PreferredSizeWidget {
  final ValueChanged<ExpectedResult> onChanged;
  final String title;

  const AppBarWithToggle({
    Key key,
    @required this.onChanged,
    @required this.title,
  }) : super(key: key);

  @override
  _AppBarWithToggleState createState() => _AppBarWithToggleState();

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}

class _AppBarWithToggleState extends State<AppBarWithToggle> {
  bool _isSelected = true;

  @override
  Widget build(BuildContext context) {
    String subtitle = _isSelected ? 'Mock WS: SUCCESS' : 'Mock WS: ERROR';
    return AppBar(
      title: ListTile(
        dense: true,
        isThreeLine: false,
        title: Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
      actions: <Widget>[
        Row(
          children: <Widget>[
            Text('ERR'),
            Switch.adaptive(
              activeColor: Colors.red,
              value: _isSelected,
              onChanged: (bool newValue) {
                String result = 'You change Mock WS result to ';
                result += newValue ? 'SUCCESS' : 'ERROR';
                showToast(result);
                setState(() {
                  _isSelected = newValue;
                });
                widget.onChanged(
                    newValue ? ExpectedResult.success : ExpectedResult.error);
              },
            ),
            Text('SUCC'),
          ],
        ),
      ],
    );
  }
}
