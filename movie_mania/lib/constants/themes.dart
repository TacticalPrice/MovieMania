import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.red, // Netflix uses red as the primary color
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white, // Background color of the scaffold
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white, // Background color of app bar
    elevation: 0, // No shadow beneath app bar
    iconTheme: IconThemeData(color: Colors.black), // Color of icons in app bar
    titleTextStyle: TextStyle(
      color: Colors.black, // Text color of app bar title
      fontSize: 20.0, // Font size of app bar title
      fontWeight: FontWeight.bold, // Font weight of app bar title
    ),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.red,
    labelStyle: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold), // Selected tab label color
    unselectedLabelColor: Colors.black,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: Colors.red),
    ), // Unselected tab label color
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold), // Headline text style
    bodyMedium: TextStyle(fontSize: 16.0), // Body text style
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[200], 
    contentPadding: EdgeInsets.symmetric(horizontal: 10),// Light grey background
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.red),
    ),
    labelStyle: const TextStyle(color: Colors.red),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.red; // Switch thumb color when selected
      }
      return Colors.grey; // Switch thumb color when not selected
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.red[200]; // Switch track color when selected
      }
      return Colors.grey[400]; // Switch track color when not selected
    }),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.red,
    unselectedItemColor: Colors.grey,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Colors.red,
  ),
  listTileTheme: ListTileThemeData(
    selectedTileColor: Colors.red[100],
  ),
);

final ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.red,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black, // Background color of the scaffold
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black, // Background color of app bar
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white), // Color of icons in app bar
    titleTextStyle: TextStyle(
      color: Colors.white, // Text color of app bar title
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.red,
    labelStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    unselectedLabelColor: Colors.white,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: Colors.red),
    ),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white), // Headline text style
    bodyMedium:
        TextStyle(fontSize: 16.0, color: Colors.white), // Body text style
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[600],
    contentPadding: EdgeInsets.symmetric(horizontal: 10),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.red),
    ),
    labelStyle: const TextStyle(color: Colors.red),
  ),
  cardColor: Colors.red,
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.red; // Switch thumb color when selected
      }
      return Colors.grey; // Switch thumb color when not selected
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.red[200]; // Switch track color when selected
      }
      return Colors.grey[800]; // Switch track color when not selected
    }),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.red,
    unselectedItemColor: Colors.grey,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Colors.red,
  ),
  listTileTheme: ListTileThemeData(
    selectedTileColor: Colors.red[100],
  ),
);
