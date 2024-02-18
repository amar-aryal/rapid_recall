import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(Brightness.light)) {
    // later initial is read from local storage
    on<ThemeEvent>((event, emit) {
      if (event == ThemeEvent.bright) {
        emit(ThemeState(Brightness.light));
      } else {
        emit(ThemeState(Brightness.dark));
      }
    });
  }
}
