import 'package:flutter/material.dart';

class DefaultTheme {
  static const Color primaryColor = Colors.blue;
  static const Color accentColor = Colors.amber;
  static const Color blueGrey700 = Color.fromRGBO(80, 93, 111, 0.7);
  static const Color errorColor = Color(0xffb00020);

  static get theme => ThemeData(
        primarySwatch: primaryColor,
        accentColor: accentColor,
        fontFamily: 'Roboto',
        // primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white,
        // listTileTheme: const ListTileThemeData(
        //   selectedColor: Colors.white,
        //   selectedTileColor: primaryColor,
        // ),
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          backgroundColor: primaryColor,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          // constraints: const BoxConstraints(
          //     minHeight: 65), // 52 is not enough for showing the error
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: primaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          fillColor: const Color.fromRGBO(240, 242, 244, 0.57),
          filled: true,
          hintStyle: const TextStyle(
            color: blueGrey700,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: errorColor),
            borderRadius: BorderRadius.circular(8),
          ),
          labelStyle: const TextStyle(
            color: blueGrey700,
          ),
          // floatingLabelStyle: const TextStyle(
          //   color: primaryColor,
          // ),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: errorColor)),
          errorStyle: const TextStyle(
            color: errorColor,
            // backgroundColor: Color.fromRGBO(176, 0, 32, 0.05),
          ),
          focusColor: const Color.fromRGBO(55, 135, 255, 0.05),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14)),
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      );
}
