import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:state_management_showcase/util/util_index.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
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

class LoginEvent extends AccountEvent {
  final ExpectedResult expectedResult;

  const LoginEvent({this.expectedResult});

  @override
  List<Object> get props => [expectedResult];
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

class ValidationButtonToEnable extends AccountState {}

class ValidationButtonToDisable extends AccountState {}

class RequestGetStarted extends AccountState {}

class RequestSuccess extends AccountState {}

class RequestFailed extends AccountState {}

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  // Keep the previous username
  String _username;

  // Keep the previous password
  String _password;

  // Keep the valid state of username
  bool _validUsername = false;

  // Keep the valid state of password
  bool _validPassword = false;

  AppRepo _appRepo;

  AccountBloc() {
    _appRepo = AppRepo();
  }

  String get username => _username;

  @override
  AccountState get initialState => UninitializedValidation();

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    bool isValidatingData = false;

    Fimber.d('... processing $event');
    if (event is UsernameValidationEvent) {
      isValidatingData = true;

      _username = event.username;
      _validUsername = isValidUsername(_username);

      // The first time, email is null, so we don't need to show the error
      // Only show error when user starts typing anything in Username TextField
      if (!_validUsername && _username != null) {
        yield EmailValidationFailed();
      } else {
        yield EmailValidationSuccess();
      }
    } else if (event is PasswordValidationEvent) {
      isValidatingData = true;

      _password = event.password;
      _validPassword = isValidPassword(_password);

      // The first time, password is null, so we don't need to show the error
      // Only show error when user starts typing anything in Password TextField
      if (!_validPassword && _password != null) {
        yield PasswordValidationFailed();
      } else {
        yield PasswordValidationSuccess();
      }
    } else if (event is LoginEvent) {
      yield RequestGetStarted();

      ApiState apiState = await _appRepo.login(event.expectedResult);
      if (apiState == ApiState.success) {
        yield RequestSuccess();
      } else {
        yield RequestFailed();
      }
    }

    if (isValidatingData) {
      Fimber.d('isValidatingData: validUsername=$_validUsername, '
          'validPassword=$_validPassword');
      // If username or password is invalid, don't enable button
      if (_validUsername && _validPassword) {
        yield ValidationButtonToEnable();
      } else {
        yield ValidationButtonToDisable();
      }
    }
  }
}
