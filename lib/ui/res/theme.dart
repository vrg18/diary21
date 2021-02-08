import 'package:diary/ui/res/colors.dart';
import 'package:flutter/material.dart';

/// Темы приложения

final mainTheme = ThemeData(
  primaryColor: primaryAppColor,
//  accentColor: primaryAppColor,
scaffoldBackgroundColor: secondaryBackgroundColor,
  backgroundColor: primaryBackgroundColor,
  buttonTheme: ButtonThemeData(
    buttonColor: appButtonColor,
    textTheme: ButtonTextTheme.primary,
  ),
);
