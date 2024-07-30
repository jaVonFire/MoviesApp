import 'package:flutter/material.dart';


class AppTheme {

  static final ThemeData lightTheme = ThemeData.light().copyWith(

      // AppBarTheme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.blue
      )
      // Icon( switchProvider.isActive ? Icons.sunny : Icons.nightlife),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(

      // AppBarTheme
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 83, 83, 83)
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 83, 83, 83)
      )

  );
}
