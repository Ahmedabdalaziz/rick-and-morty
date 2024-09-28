import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty/presentation/widgets/card_custom_widget.dart';

import '../../data/models/character_model.dart';

class ListViewCustomWidget extends StatelessWidget {
  final List<Character> characters;

  const ListViewCustomWidget({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
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
