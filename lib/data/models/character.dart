import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
class Character {
  final int id;
  final String hanzi;
  final String pinyin;
  final List<String> translations;

  Character({
    required this.id,
    required this.hanzi,
    required this.pinyin,
    required this.translations,
  });

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
