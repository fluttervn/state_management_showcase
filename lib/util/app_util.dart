import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';

const int usernameMinLength = 3;
const int usernameMaxLength = 10;

const int passwordMinLength = 2;
const int passwordMaxLength = 10;

void goBack(BuildContext context) {
  Navigator.of(context).pop();
}

void navigateToPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => page),
  );
}

void navigateToPageAndReplace(BuildContext context, Widget page) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => page),
  );
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
  );
}

void showLongToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
  );
}

void showErrorToast(String message, {bool longToast = true}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: longToast ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
    textColor: Colors.red,
  );
}

PopupHUD createProgressDialog(BuildContext context, String title) => PopupHUD(
      context,
      hud: HUD(
        label: title,
        detailLabel: 'Sending request to server... Please wait!',
      ),
    );

bool isValidUsername(String username) {
  if (username == null || username.isEmpty) return false;
  int length = username.trim().length;
  return length >= usernameMinLength && length <= usernameMaxLength;
}

bool isValidPassword(String password) {
  if (password == null || password.isEmpty) return false;
  int length = password.trim().length;
  return length >= passwordMinLength && length <= passwordMaxLength;
}

/// Generates a positive random integer uniformly distributed on the range
/// from `min`, inclusive, to `max`, exclusive.
int getRandomTemperature() {
  Random rnd = Random();
  int min = 20;
  int max = 45;
  return min + rnd.nextInt(max - min);
}
