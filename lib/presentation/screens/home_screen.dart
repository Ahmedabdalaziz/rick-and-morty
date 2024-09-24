import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/business_logic/cubit/character_cubit.dart';
import 'package:rick_and_morty/presentation/widgets/list_view_custom_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    try {
      BlocProvider.of<CharacterCubit>(context).getAllCharacter();
    }
        catch (e) {
          debugPrint('Error: $e');
        }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick and Morty Characters')),
      body: buildBlocWidget(),
    );
  }

  Widget buildBlocWidget() => BlocBuilder<CharacterCubit, CharacterState>(
    builder: (context, state){
      if (state is CharacterLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is CharacterLoaded) {
        final characters = state.character;

        if (characters.isNotEmpty) {
          return ListViewCustomWidget(characters: characters);
        } else {
          return const Center(child: Text('No characters found'));
        }
      } else if (state is CharacterError) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.message),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<CharacterCubit>(context).getAllCharacter();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }
      return const SizedBox.shrink();
    },
  );

  @override
  void dispose() {
    super.dispose();
  }
}

