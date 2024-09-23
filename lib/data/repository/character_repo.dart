import 'package:rick_and_morty/data/api_services/character_services.dart';
import 'package:rick_and_morty/data/models/character_model.dart';

class CharacterRepository {
  final CharacterServices characterServices;

  CharacterRepository(this.characterServices);

  Future<List<Character>> getCharacters() async {
    final charactersJson = await characterServices.getCharacters();
    return charactersJson.map((json) => Character.fromJson(json)).toList();
  }
}
