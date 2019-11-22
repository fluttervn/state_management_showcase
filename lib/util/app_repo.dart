import 'dart:core';

/// Type of the API result - will simulate result of AppRepo
enum ApiState {
  /// Is in loading state
  loading,

  /// successful result
  success,

  ///failed result
  error,
}

enum ExpectedResult {
  /// successful result
  success,

  ///failed result
  error,
}

final futureDelay = Future.delayed(Duration(seconds: 2));
final futureDelayShort = Future.delayed(Duration(seconds: 1));

class AppRepo {
  Future<ApiState> login(ExpectedResult expectedResult) async {
    await futureDelay;

    ApiState state = from(expectedResult);

    print('login done - result = $state');
    return state;
  }

  Future<ApiState> forgotPassword(ExpectedResult expectedResult) async {
    await futureDelay;

    ApiState state = from(expectedResult);

    print('forgotPassword done - result = $state');
    return state;
  }

  ApiState from(ExpectedResult expectedResult) {
    ApiState state;
    if (expectedResult == ExpectedResult.success) {
      state = ApiState.success;
    } else if (expectedResult == ExpectedResult.error) {
      state = ApiState.error;
    }
    return state;
  }
}

class CalculatorRepo {
  Future<int> square(int number) async {
    return number * number;
  }
}
