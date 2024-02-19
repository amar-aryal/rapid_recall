import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CharactersEvent extends Equatable {}

class GetCharactersEvent extends CharactersEvent {
  final int hskNo;

  GetCharactersEvent({this.hskNo = 1});
  @override
  List<Object> get props => [hskNo];
}

class FilterCharactersEvent extends CharactersEvent {
  final (String, int) filters;

  FilterCharactersEvent(this.filters);
  @override
  List<Object> get props => [filters];
}
