import 'dart:developer';

import '../api_services/character_services.dart';
import '../models/character_model.dart';

class CharacterRepository {
  final CharacterServices characterServices;

  CharacterRepository(this.characterServices);

  Future<List<Character>> getCharacters() async {
    final charactersJson = await characterServices.getCharacters();
    log("Data received in repo: $charactersJson");
    return charactersJson;
  }
}
