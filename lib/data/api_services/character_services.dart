import 'dart:developer';
import 'package:dio/dio.dart';
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
  }

  Future<List<dynamic>> getCharacters() async {
    try {
      Response response = await dio.get(characterUrl);
      if (response.statusCode == 200) {
        log(response.data);
        return response.data;
      } else {
        throw Exception('Failed to get characters');
      }
    } catch (error) {
      throw Exception('Failed to get characters: ${error.toString()}');
    }
  }
}
