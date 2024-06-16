import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.red, // Netflix uses red as the primary color
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white, // Background color of the scaffold
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white, // Background color of app bar
    elevation: 0, // No shadow beneath app bar
    iconTheme: IconThemeData(color: Colors.black), // Color of icons in app bar
    titleTextStyle: TextStyle(
      color: Colors.black, // Text color of app bar title
      fontSize: 20.0, // Font size of app bar title
      fontWeight: FontWeight.bold, // Font weight of app bar title
    ),
  ),
  tabBarTheme: TabBarTheme(
    labelColor: Colors.red,
    labelStyle: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold), // Selected tab label color
    unselectedLabelColor: Colors.black,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: Colors.red),
    ), // Unselected tab label color
  ),
  textTheme: TextTheme(
    headline6: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold), // Headline text style
    bodyText2: TextStyle(fontSize: 16.0), // Body text style
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.red,
    unselectedItemColor: Colors.grey,
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Colors.red,
  ),

  listTileTheme: ListTileThemeData(
    //iconColor: Colors.black,
    //textColor: Colors.black,
    //tileColor: Colors.white,
    selectedTileColor: Colors.red[100],
  ),
);

final ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.red,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black, // Background color of the scaffold
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black, // Background color of app bar
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white), // Color of icons in app bar
    titleTextStyle: TextStyle(
      color: Colors.white, // Text color of app bar title
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  tabBarTheme: TabBarTheme(
    labelColor: Colors.red,
    labelStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    unselectedLabelColor: Colors.white,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: Colors.red),
    ),
  ),
  textTheme: TextTheme(
    headline6: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white), // Headline text style
    bodyText2:
        TextStyle(fontSize: 16.0, color: Colors.white), // Body text style
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.red,
    unselectedItemColor: Colors.grey,
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Colors.red,
  ),

  listTileTheme: ListTileThemeData(
    //iconColor: Colors.black,
    //textColor: Colors.black,
    //tileColor: Colors.white,
    selectedTileColor: Colors.red[100],
  ),
);
