import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/helper/constants.dart';

class CharacterServices {
  late final Dio dio;

  CharacterServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      receiveDataWhenStatusError: true,
    );

    dio = Dio(options);
  }

  Future<List<Character>> getCharacters() async {
    try {
      Response response = await dio.get("character");
      if (response.statusCode == 200) {
        log("success dio");
        return (response.data['results'] as List)
            .map((character) => Character.fromJson(character))
            .toList();
      } else {
        throw Exception('Failed to get characters');
      }
    } catch (error) {
      throw Exception('Failed to get characters: ${error.toString()}');
    }
  }
}
