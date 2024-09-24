import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/business_logic/cubit/character_cubit.dart';
import 'package:rick_and_morty/data/api_services/character_services.dart';
import 'package:rick_and_morty/data/repository/character_repo.dart';
import 'package:rick_and_morty/presentation/screens/details_screen.dart';
import 'package:rick_and_morty/presentation/screens/home_screen.dart';

class AppRouter {
  late CharacterRepository characterRepository;
  late CharacterCubit characterCubit;

  AppRouter() {
    characterRepository = CharacterRepository(CharacterServices());
    characterCubit = CharacterCubit(characterRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => characterCubit,
                  child: const HomeScreen(),
                ));
      case Routes.details:
        return MaterialPageRoute(builder: (context) => const DetailsScreen());
      default:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
    }
  }
}

class Routes {
  static const String home = '/home';
  static const String details = '/details';
}
