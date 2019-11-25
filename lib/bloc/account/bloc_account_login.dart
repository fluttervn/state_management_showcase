import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:state_management_showcase/util/util_index.dart';

import 'account_bloc.dart';

ExpectedResult _expectedResult = ExpectedResult.success;

class BlocAccountLoginPage extends StatelessWidget {
  BlocAccountLoginPage() {
    Fimber.d('init BlocAccountLoginPage');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountBloc>(
      builder: (context) => AccountBloc(),
      child: _BlocAccountLoginChildPage(),
    );
  }
}

class _BlocAccountLoginChildPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithToggle(
        title: 'LoginForm - flutter_bloc',
        onChanged: (ExpectedResult value) {
          _expectedResult = value;
        },
      ),
      body: _BlocLoginForm(),
    );
  }
}

class _BlocLoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final AccountBloc accountBloc = BlocProvider.of<AccountBloc>(context);
    return InputUsernameFormContainer(
      children: <Widget>[
        BlocBuilder<AccountBloc, AccountState>(
          condition: (prevState, state) {
            return state is EmailValidationFailed ||
                state is EmailValidationSuccess;
          },
          builder: (context, state) {
            Fimber.d('UsernameTextField: state=$state');
            bool isValid = state is EmailValidationSuccess
                ? true
                : state is UninitializedValidation ? true : false;
            return UsernameTextField(
              onChanged: (String value) {
                accountBloc.add(UsernameValidationEvent(value));
              },
              showError: !isValid,
            );
          },
        ),
        BlocBuilder<AccountBloc, AccountState>(
          condition: (prevState, state) {
            return state is PasswordValidationFailed ||
                state is PasswordValidationSuccess;
          },
          builder: (context, state) {
            Fimber.d('PasswordTextField: state=$state');
            bool isValid = state is PasswordValidationSuccess
                ? true
                : state is UninitializedValidation ? true : false;
            return PasswordTextField(
              onChanged: (String value) {
                accountBloc.add(PasswordValidationEvent(value));
              },
              showError: !isValid,
            );
          },
        ),
        BlocListener<AccountBloc, AccountState>(
          listener: (context, state) {},
          child: BlocBuilder<AccountBloc, AccountState>(
            condition: (prevState, state) {
              return state is ValidationButtonToEnable ||
                  state is ValidationButtonToDisable ||
                  state is RequestGetStarted ||
                  state is RequestSuccess ||
                  state is RequestFailed;
            },
            builder: (context, state) {
              Fimber.d('ButtonLoginWithUsername: state=$state');
              bool isEnable;
              bool isLoading;
              if (state is UninitializedValidation) {
                isLoading = false;
                isEnable = false;
              } else if (state is ValidationButtonToEnable) {
                isLoading = false;
                isEnable = true;
              } else if (state is ValidationButtonToDisable) {
                isLoading = false;
                isEnable = false;
              } else if (state is RequestGetStarted) {
                isLoading = true;
                isEnable = true;
              } else if (state is RequestSuccess || state is RequestFailed) {
                isLoading = false;
                isEnable = true;
              }
              return ButtonLoginWithUsername(
                text: 'Login with username & password',
                onPressed: () {
                  accountBloc.add(LoginEvent());
                },
                isEnable: isEnable,
                isLoading: isLoading,
              );
            },
          ),
        ),
        ButtonResetName(
          onPressed: () {
            /*navigateToPage(
                context,
                SetStateAccountForgotPage(
                  username: _username,
                ));*/
          },
        ),
      ],
    );
  }

/*_doLogin() async {
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
      navigateToPageAndReplace(context, BlocAccountFinalPage());
    }
  }*/
}
