import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/localization_bloc.dart';

class LanguageChange extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Change'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('English'),
            onTap: () {
              context.read<LocalizationBloc>().add(LocaleChanged(Locale('en')));
            },
          ),
          ListTile(
            title: Text('Spanish'),
            onTap: () {
              context.read<LocalizationBloc>().add(LocaleChanged(Locale('es')));
            },
          ),
          // Add other languages here
        ],
      ),
    );
  }
}
