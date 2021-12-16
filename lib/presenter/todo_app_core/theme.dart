import 'package:flutter/material.dart';

class TodoAppTheme {
  static ThemeData get theme {
    final themeData = ThemeData.dark();
    final textTheme = themeData.textTheme;
    final body1 =
        textTheme.bodyText2?.copyWith(decorationColor: Colors.transparent);

    return ThemeData.dark().copyWith(
      primaryColor: Colors.grey[800],
      accentColor: Colors.cyan[300],
      buttonColor: Colors.grey[800],
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Colors.cyan[100],
      ),
      toggleableActiveColor: Colors.cyan[300],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.cyan[300],
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: themeData.dialogBackgroundColor,
        contentTextStyle: body1,
        actionTextColor: Colors.cyan[300],
      ),
      textTheme: textTheme.copyWith(bodyText1: body1),
    );
  }
}
