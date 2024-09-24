import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/data/repository/character_repo.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepository characterRepository;
  late List<Character> characters;

  CharacterCubit(this.characterRepository) : super(CharacterInitial());

  Future<List<Character>> getAllCharacter() async {
    emit(CharacterLoading());
    try {
      final characters = await characterRepository.getCharacters();
      emit(CharacterLoaded(characters));
      this.characters = characters;
      print("$characters");
      return characters;
    } catch (error) {
      emit(CharacterError('Failed to fetch characters'));
      return [];
    }
  }
}
