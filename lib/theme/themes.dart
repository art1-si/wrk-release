import 'package:flutter/material.dart';

enum Themes { defult }

class ThemesData {
  final ThemeData defualt = ThemeData(
    dialogBackgroundColor: Color(0xff19212A),
    fontFamily: "SourceSansPro",
    brightness: Brightness.light,
    backgroundColor: Color(0xff1B2333),
    primaryColor: Color(0xff242F45),
    primaryColorDark: Color(0xff1E274C),
    primaryColorLight: Color(0xff303234),
    dividerColor: Colors.white.withOpacity(0.04),
    cardColor: Color(0xff343A40),
    accentColor: Color(0xff387FFF),
    canvasColor: Color(0xff272B30),
    textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        headline2: TextStyle(
          color: Colors.grey.withOpacity(0.1),
          //fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        headline4: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        headline5: TextStyle(
          color: Colors.white,
          fontSize: 28,
        ),
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        bodyText1: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        bodyText2: TextStyle(
          color: Colors.white70,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        subtitle1: TextStyle(color: Colors.blue),
        button: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        caption: TextStyle(
          color: Colors.white60,
          letterSpacing: 1.0,
        ),
        overline: TextStyle(color: Colors.white60)),
  );
}
