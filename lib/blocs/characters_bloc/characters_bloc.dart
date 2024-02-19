import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_recall/blocs/characters_bloc/characters_event.dart';
import 'package:rapid_recall/blocs/characters_bloc/characters_state.dart';
import 'package:rapid_recall/data/models/character.dart';
import 'package:rapid_recall/data/repository/data_repository.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final DataRepository _dataRepository;

  List<Character> _characters = [];

  CharactersBloc(this._dataRepository) : super(CharactersLoadingState()) {
    on<CharactersEvent>((event, emit) async {
      if (event is GetCharactersEvent) {
        await getAllCharacters(event, emit);
      } else if (event is FilterCharactersEvent) {
        filterCharacters(event, emit, event.filters);
      }
    });
  }

  Future getAllCharacters(
      CharactersEvent event, Emitter<CharactersState> emit) async {
    emit(CharactersLoadingState());

    try {
      _characters = await _dataRepository.getCharactersData(1);

      emit(CharactersLoadedState(_characters));
    } catch (e) {
      emit(CharactersErrorState(e.toString()));
    }
  }

  filterCharacters(CharactersEvent event, Emitter<CharactersState> emit,
      (String, int) filters) {
    try {
      final filteredCharacters =
          _characters.where((element) => element.pinyin.startsWith(filters.$1));

      _characters = [...filteredCharacters];

      emit(CharactersLoadedState(_characters));
    } catch (e) {
      emit(CharactersErrorState(e.toString()));
    }
  }
}
