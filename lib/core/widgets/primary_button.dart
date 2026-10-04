import 'package:flutter/material.dart';
import 'package:tourist_guide_app/core/theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  static const _height = 60.0;
  static const _radius = BorderRadius.all(Radius.circular(20));

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: _radius,
        gradient: const LinearGradient(
          begin: Alignment(-0.97, 0.78),
          end: Alignment(0.95, -0.77),
          colors: [AppColors.primary, AppColors.secondary],
        ),
        border: Border.all(color: Colors.black.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            offset: const Offset(0, 5),
            blurRadius: 5,
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: _radius,
          child: SizedBox(
            height: _height,
            width: double.infinity,
            child: Center(
              child: isLoading
                  ? const SizedBox.square(
                      dimension: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
