import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:state_management_showcase/util/util_index.dart';

import 'setstate_complex_forgot.dart';
import 'setstate_complex_home.dart';

ExpectedResult _expectedResult = ExpectedResult.success;

class SetStateComplexLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithToggle(
        title: 'Login - setState',
        onChanged: (ExpectedResult value) {
          _expectedResult = value;
        },
      ),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  ApiState _state;
  String _username;
  String _password;

  AppRepo _appRepo = AppRepo();

  _doLogin() async {
    setState(() {
      _state = ApiState.loading;
    });
    final popup = createProgressDialog(context, 'Login');
    popup.show();

    ApiState state = await _appRepo.login(_expectedResult);

    setState(() {
      _state = state;
    });
    popup.dismiss();

    if (state == ApiState.error) {
      showErrorToast('Login with username failed!');
    } else if (state == ApiState.success) {
      print('Success - will navigate to LoginHomePage');
      navigateToPageAndReplace(context, SetStateComplexHomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    bool validUsername = isValidUsername(_username);
    bool validPassword = isValidPassword(_password);
    bool showUsernameErr = _username != null && !validUsername;
    bool showPasswordErr = _password != null && !validPassword;

    return InputUsernameFormContainer(
      children: <Widget>[
        UsernameTextField(
          onChanged: (String value) {
            setState(() {
              _username = value;
            });
          },
          showError: showUsernameErr,
        ),
        PasswordTextField(
          onChanged: (String value) {
            setState(() {
              _password = value;
            });
          },
          showError: showPasswordErr,
        ),
        ButtonLoginWithUsername(
          text: 'Login with username & password',
          onPressed: _doLogin,
          isEnable: validUsername && validPassword,
          isLoading: _state == ApiState.loading,
        ),
        ButtonResetName(
          onPressed: () {
            navigateToPage(
                context,
                SetStateComplexForgotPage(
                  username: _username,
                ));
          },
        ),
      ],
    );
  }
}
