import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_recall/blocs/characters_bloc/characters_event.dart';
import 'package:rapid_recall/blocs/characters_bloc/characters_state.dart';
import 'package:rapid_recall/data/repository/data_repository.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final DataRepository _dataRepository;

  CharactersBloc(this._dataRepository) : super(CharactersLoadingState()) {
    on<CharactersEvent>((event, emit) async {
      emit(CharactersLoadingState());

      try {
        final characters = await _dataRepository.getCharactersData(1);

        emit(CharactersLoadedState(characters));
      } catch (e) {
        emit(CharactersErrorState(e.toString()));
      }
    });
  }
}
