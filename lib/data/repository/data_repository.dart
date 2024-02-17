import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:rapid_recall/data/models/character.dart';

class DataRepository {
  Future<List<Character>> getCharactersData(int hskNumber) async {
    try {
      final loadedString =
          await rootBundle.loadString('assets/json/hsk-level-$hskNumber.json');

      final List data = json.decode(loadedString);

      final charactersList = data.map((e) => Character.fromJson(e)).toList();

      return charactersList;
    } catch (e) {
      throw Exception();
    }
  }
}
