import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:state_management_showcase/util/util_index.dart';

import 'account_bloc.dart';
import 'bloc_account_final.dart';
import 'bloc_account_forgot.dart';

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
          listener: (context, state) {
            Fimber.d('BlocListener DONE: $state');
            final PopupHUD popup = createProgressDialog(context, 'Login');
            if (state is RequestGetStarted) {
              popup.show();
            } else if (state is RequestFailed) {
              popup.dismiss();
              showErrorToast('Login with username failed!');
            } else if (state is RequestSuccess) {
              popup.dismiss();
              print('Success - will navigate to LoginHomePage');
              navigateToPage(context, BlocAccountFinalPage());
            }
          },
          condition: (prevState, state) {
            return state is ValidationButtonToEnable ||
                state is ValidationButtonToDisable ||
                state is RequestGetStarted ||
                state is RequestSuccess ||
                state is RequestFailed;
          },
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
              bool isLoading = state is RequestGetStarted ? true : false;
              bool isEnable = false;
              if (state is UninitializedValidation) {
                isEnable = false;
              } else if (state is ValidationButtonToEnable) {
                isEnable = true;
              } else if (state is ValidationButtonToDisable) {
                isEnable = false;
              } else if (state is RequestGetStarted) {
                isEnable = false;
              } else if (state is RequestSuccess || state is RequestFailed) {
                isEnable = true;
              }
              return ButtonLoginWithUsername(
                text: 'Login with username & password',
                onPressed: () {
                  Fimber.d('ButtonLoginWithUsername: do login with '
                      'expectedResult=$_expectedResult');
                  accountBloc.add(LoginEvent(expectedResult: _expectedResult));
                },
                isEnable: isEnable,
                isLoading: isLoading,
              );
            },
          ),
        ),
        ButtonResetName(
          onPressed: () {
            navigateToPage(
                context,
                BlocAccountForgotPage(
                  username: accountBloc.username,
                ));
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
