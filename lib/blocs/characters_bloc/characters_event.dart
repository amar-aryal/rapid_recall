import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CharactersEvent extends Equatable {}

class GetCharactersEvent extends CharactersEvent {
  @override
  List<Object> get props => [];
}

class FilterCharactersEvent extends CharactersEvent {
  final (String, int) filters;

  FilterCharactersEvent(this.filters);
  @override
  List<Object> get props => [filters];
}
