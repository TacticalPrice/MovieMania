import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class ThemeState extends Equatable {
  final ThemeData themeData;

  const ThemeState(this.themeData);

  @override
  List<Object?> get props => [themeData];
}

class LightTheme extends ThemeState {
  LightTheme() : super(_buildLightTheme());

  static ThemeData _buildLightTheme() {
    return ThemeData.light();
  }
}

class DarkTheme extends ThemeState {
  DarkTheme() : super(_buildDarkTheme());

  static ThemeData _buildDarkTheme() {
    return ThemeData.dark();
  }
}
