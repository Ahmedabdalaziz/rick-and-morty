import 'package:flutter/material.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/presentation/widgets/card_custom_widget.dart';

class ListViewCustomWidget extends StatelessWidget {
  final List<Character> characters;

  const ListViewCustomWidget({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemCount: characters.length,
      itemBuilder: (BuildContext context, int index) {
        return CustomCard(
          character: characters[index],
        );
      },
    );
  }
}
