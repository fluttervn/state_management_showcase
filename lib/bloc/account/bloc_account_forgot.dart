import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:state_management_showcase/util/common_account_widgets.dart';
import 'package:state_management_showcase/util/util_index.dart';

ExpectedResult _expectedResult = ExpectedResult.success;

class BlocAccountForgotPage extends StatelessWidget {
  final String username;

  BlocAccountForgotPage({Key key, this.username}) : super(key: key) {
    print('BlocAccountForgotPage: username=$username');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithToggle(
        title: 'Forgot password - flutter_bloc',
        onChanged: (ExpectedResult value) {
          _expectedResult = value;
        },
      ),
      body: _BlocForgotForm(username: username),
    );
  }
}

class _BlocForgotForm extends StatefulWidget {
  final String username;

  const _BlocForgotForm({Key key, this.username}) : super(key: key);

  @override
  _BlocForgotFormState createState() => _BlocForgotFormState();
}

class _BlocForgotFormState extends State<_BlocForgotForm> {
  ApiState _state;
  String _username;

  AppRepo _appRepo = AppRepo();

  @override
  void initState() {
    super.initState();
    // Only accept non-null & non-empty username when start app because
    // when username is null, we don't show any error, but if username
    // is empty or invalid then error will be shown
    _username = widget.username == null || widget.username.isEmpty
        ? null
        : widget.username;
  }

  Future<void> _doForgot() async {
    final popup = createProgressDialog(context, 'Reset password');

    setState(() {
      _state = ApiState.loading;
    });
    await popup.show();

    ApiState state = await _appRepo.forgotPassword(_expectedResult);
    setState(() {
      _state = state;
    });
    popup.dismiss();
    if (state == ApiState.error) {
      showErrorToast('Forgot with username failed!');
    } else if (state == ApiState.success) {
      print('Success - will navigate to LoginPage');
      showLongToast('Reset password is done. Please check your email');
      goBack(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool validUsername = isValidUsername(_username);
    bool showUsernameErr = _username != null && !validUsername;

    return InputUsernameFormContainer(
      children: <Widget>[
        UsernameTextField(
          onChanged: (String value) {
            setState(() {
              _username = value;
            });
          },
          initText: _username,
          showError: showUsernameErr,
        ),
        ButtonLoginWithUsername(
          text: 'Request new password',
          onPressed: _doForgot,
          isEnable: validUsername,
          isLoading: _state == ApiState.loading,
        ),
      ],
    );
  }
}
