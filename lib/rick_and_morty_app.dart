import 'package:flutter/material.dart';
import 'package:rick_and_morty/app_router.dart';

class RickAndMortyApp extends StatelessWidget {
  //Singleton pattern//
  RickAndMortyApp._internal();

  static final RickAndMortyApp _instance = RickAndMortyApp._internal();

  factory RickAndMortyApp() => RickAndMortyApp._instance;

  final AppRouter router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
      initialRoute: Routes.home,
    );
  }
}
