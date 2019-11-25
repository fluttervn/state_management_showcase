import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:state_management_showcase/util/util_index.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
}

class UsernameValidationEvent extends AccountEvent {
  final String username;

  const UsernameValidationEvent(this.username);

  @override
  List<Object> get props => [username];
}

class PasswordValidationEvent extends AccountEvent {
  final String password;

  const PasswordValidationEvent(this.password);

  @override
  List<Object> get props => [password];
}

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class UninitializedValidation extends AccountState {}

class EmailValidationFailed extends AccountState {}

class EmailValidationSuccess extends AccountState {}

class PasswordValidationFailed extends AccountState {}

class PasswordValidationSuccess extends AccountState {}

class UpdateButtonState extends AccountState {
  final bool isButtonEnable;
  final bool isButtonLoading;

  const UpdateButtonState({
    this.isButtonEnable,
    this.isButtonLoading,
  });

  @override
  List<Object> get props => [isButtonEnable, isButtonLoading];
}

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  String _email;
  String _password;

  @override
  AccountState get initialState => UninitializedValidation();

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    bool isValidatingData = false;
    bool isPerformingNetwork = false;

    bool validUsername = true;
    bool validPassword = true;

    if (event is UsernameValidationEvent) {
      isValidatingData = true;

      _email = event.username;
      validUsername = isValidUsername(_email);

      // The first time, email is null, so we don't need to show the error
      // Only show error when user starts typing anything in Username TextField
      if (!validUsername && _email != null) {
        yield EmailValidationFailed();
      } else {
        yield EmailValidationSuccess();
      }
    } else if (event is PasswordValidationEvent) {
      isValidatingData = true;

      _password = event.password;
      validPassword = isValidPassword(_password);

      // The first time, password is null, so we don't need to show the error
      // Only show error when user starts typing anything in Password TextField
      if (!validPassword && _password != null) {
        yield PasswordValidationFailed();
      } else {
        yield PasswordValidationSuccess();
      }
    }

    if (isValidatingData) {
      // If username or password is invalid, don't enable button
      bool isButtonEnable = validUsername && validPassword;
      yield UpdateButtonState(
        isButtonEnable: isButtonEnable,
        isButtonLoading: false,
      );
    } else if (isPerformingNetwork) {
      // Update button with loading state
      yield UpdateButtonState(
        isButtonEnable: true,
        isButtonLoading: true,
      );
    }
  }
}
