import 'package:flutter/material.dart';
import 'package:rick_and_morty/app_router.dart';
import 'package:rick_and_morty/presentation/theming.dart';

class RickAndMortyApp extends StatefulWidget {
  //Singleton pattern
  RickAndMortyApp._internal();

  static final RickAndMortyApp _instance = RickAndMortyApp._internal();

  factory RickAndMortyApp() => RickAndMortyApp._instance;

  final AppRouter router = AppRouter();

  @override
  _RickAndMortyAppState createState() => _RickAndMortyAppState();
}

class _RickAndMortyAppState extends State<RickAndMortyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: widget.router.generateRoute,
      initialRoute: Routes.home,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
    );
  }
}
