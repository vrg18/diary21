import 'package:diary/ui/res/colors.dart';
import 'package:flutter/material.dart';

/// Темы приложения

final mainTheme = ThemeData(
  primaryColor: primaryAppColor,
  accentColor: Colors.indigo,
  scaffoldBackgroundColor: primaryBackgroundColor,
  backgroundColor: primaryBackgroundColor,
  primarySwatch: Colors.indigo,
  buttonTheme: ButtonThemeData(
    buttonColor: appButtonColor,
    textTheme: ButtonTextTheme.primary,
  ),
);
