import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    primaryColor: const Color(0xFFf6faff),
    scaffoldBackgroundColor: const Color(0xFFf6faff),
    fontFamily: 'Roboto',
    appBarTheme: appBarTheme(),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Color(0xFF005e8e),
    ),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Color(0xFFf6faff),
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(0XFF202020)),
    titleTextStyle: TextStyle(
      color: Color(0XFF8B8B8B),
      fontSize: 18,
    ),
  );
}
