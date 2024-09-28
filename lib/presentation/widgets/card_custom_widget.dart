import 'package:flutter/material.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/helper/colors.dart';

class CustomCard extends StatelessWidget {
  final Character? character;

  const CustomCard({required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.surfaceColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.greyMedium.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Image.network(
              "${character!.image}",
              height: 350,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return _buildLoadingIndicator(loadingProgress);
              },
              errorBuilder: (context, error, stackTrace) {
                return _buildErrorPlaceholder();
              },
            ),
            _buildCharacterInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator(ImageChunkEvent loadingProgress) {
    return Container(
      height: 350,
      width: double.infinity,
      color: AppColors.greyLight.withOpacity(0.1),
      child: Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
              : null,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      height: 350,
      width: double.infinity,
      color: AppColors.greyLight.withOpacity(0.1),
      child: const Center(
        child: Icon(
          Icons.error,
          color: AppColors.errorColor,
          size: 40,
        ),
      ),
    );
  }

  Widget _buildCharacterInfo() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primaryVariant.withOpacity(0.7),
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${character!.name}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Status: ${character!.status}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
