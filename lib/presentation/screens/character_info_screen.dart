import 'package:flutter/material.dart';
import 'package:rick_and_morty/helper/colors.dart';

import '../../data/models/character_model.dart';

class CharacterInfoScreen extends StatelessWidget {
  final Character character;

  const CharacterInfoScreen({super.key, required this.character});

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 600,
      backgroundColor: AppColors.greyMedium,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.name!,
          style: const TextStyle(
            color: AppColors.surfaceColor,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 5.0,
                color: Colors.black54,
              ),
            ],
          ),
        ),
        background: Hero(
          tag: 'hero-tag-${character.id}',
          child: Image.network(
            "${character.image}",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterDetails() {
    return Container(
      height: 700,
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.black, // Set the background color to black
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Character Details',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.greyLight, // Change to a lighter color
            ),
          ),
          const SizedBox(height: 10),
          _buildDetailRow('Species:', character.species),
          _buildDetailRow('Status:', character.status),
          _buildDetailRow('Type:', character.type ?? 'N/A'),
          _buildDetailRow('Gender:', character.gender ?? 'N/A'),
          _buildDetailRow('Origin:', character.origin?.name ?? 'N/A'), // Display origin name
          _buildDetailRow('Created At:', character.created ?? 'Unknown'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, color: AppColors.greyLight), // Change color to match theme
          ),
          Text(
            value ?? 'N/A',
            style: const TextStyle(fontSize: 18, color: AppColors.greyLight),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: _buildCharacterDetails(),
          ),
        ],
      ),
    );
  }
}
