// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      id: json['id'] as int,
      hanzi: json['hanzi'] as String,
      pinyin: json['pinyin'] as String,
      translations: (json['translations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'id': instance.id,
      'hanzi': instance.hanzi,
      'pinyin': instance.pinyin,
      'translations': instance.translations,
    };
