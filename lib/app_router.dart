import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/business_logic/cubit/character_cubit.dart';
import 'package:rick_and_morty/data/api_services/character_services.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/data/repository/character_repo.dart';
import 'package:rick_and_morty/presentation/screens/character_info_screen.dart';
import 'package:rick_and_morty/presentation/screens/home_screen.dart';

class AppRouter {
  late CharacterRepository characterRepository;

  AppRouter() {
    characterRepository = CharacterRepository(CharacterServices());
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => CharacterCubit(characterRepository),
                  child: const HomeScreen(),
                ));
      case Routes.details:
        final Character character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (context) => CharacterInfoScreen(character: character));
      default:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
    }
  }
}

class Routes {
  static const String home = '/home';
  static const String details = '/details';
}
