import 'package:flutter/material.dart';
import 'package:tourist_guide_app/core/theme/app_colors.dart';

/// Illustration with a title and description, used for empty and error states.
class StatusMessage extends StatelessWidget {
  const StatusMessage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.message,
  });

  final String imagePath;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300, maxHeight: 260),
            child: Image.asset(imagePath),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
