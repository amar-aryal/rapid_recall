import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rapid_recall/data/models/character.dart';

@immutable
abstract class CharactersState extends Equatable {}

class CharactersLoadingState extends CharactersState {
  @override
  List<Object> get props => [];
}

class CharactersLoadedState extends CharactersState {
  final List<Character> characters;

  CharactersLoadedState(this.characters);

  @override
  List<Object> get props => [characters];
}

class CharactersErrorState extends CharactersState {
  final String error;

  CharactersErrorState(this.error);

  @override
  List<Object> get props => [error];
}
