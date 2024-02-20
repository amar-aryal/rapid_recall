import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_recall/blocs/characters_bloc/characters_event.dart';
import 'package:rapid_recall/blocs/characters_bloc/characters_state.dart';
import 'package:rapid_recall/data/models/character.dart';
import 'package:rapid_recall/data/repository/data_repository.dart';
import 'package:rapid_recall/utils/alphabet_tones.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final DataRepository _dataRepository;

  List<Character> _characters = [];

  CharactersBloc(this._dataRepository) : super(CharactersLoadingState()) {
    on<CharactersEvent>((event, emit) async {
      if (event is GetCharactersEvent) {
        await getAllCharacters(event, emit);
      } else if (event is FilterCharactersEvent) {
        filterCharacters(event, emit);
      }
    });
  }

  Future getAllCharacters(
      CharactersEvent event, Emitter<CharactersState> emit) async {
    emit(CharactersLoadingState());

    try {
      final hskNo = (event as GetCharactersEvent).hskNo;
      _characters = await _dataRepository.getCharactersData(hskNo);

      emit(CharactersLoadedState(_characters));
    } catch (e) {
      emit(CharactersErrorState(e.toString()));
    }
  }

  filterCharacters(CharactersEvent event, Emitter<CharactersState> emit) {
    try {
      final filters = (event as FilterCharactersEvent).filters;

      List<Character> filteredCharacters = [];

      if (filters.$1 case ('a' || 'e' || 'i' || 'o' || 'u')) {
        RegExp pattern = vowelsRegexGenerator(filters.$1);

        filteredCharacters = _characters
            .where((element) => element.pinyin.startsWith(pattern))
            .toList();
      } else {
        filteredCharacters = _characters
            .where((element) => element.pinyin.startsWith(filters.$1))
            .toList();
      }

      _characters = [...filteredCharacters];

      emit(CharactersLoadedState(_characters));
    } catch (e) {
      emit(CharactersErrorState(e.toString()));
    }
  }
}
