import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_recall/UI/characters_grid_screen.dart';
import 'package:rapid_recall/blocs/theme_bloc/theme_bloc.dart';
import 'package:rapid_recall/blocs/theme_bloc/theme_state.dart';
import 'package:rapid_recall/data/repository/data_repository.dart';

import 'blocs/theme_bloc/theme_event.dart';

void main() {
  runApp(const MyApp());
}

//TODO: find a way to programtically write traditional character in each json object
// Alternatively: find other json files with traditional characters in github

//TODO: theme colors choose for light and dark theme
// TODO: routing setup, autoroute or go router
// TODO: parameter for hsk nos - DONE
//TODO: Theme: after initial data fetch done, write tests

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      // try to streamline code
      create: (context) => DataRepository(),
      child: BlocProvider(
        create: (context) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context_, state) {
            final ThemeBloc themeBloc = BlocProvider.of<ThemeBloc>(context_);

            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.deepPurple,
                  brightness: state.theme,
                ),
                useMaterial3: true,
              ),
              home: CharacterGridScreen(onThemeChange: () {
                themeBloc.add(
                  state.theme == Brightness.light
                      ? ThemeEvent.dark
                      : ThemeEvent.bright,
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
