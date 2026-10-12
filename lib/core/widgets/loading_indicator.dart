import 'package:flutter/cupertino.dart';
import 'package:tourist_guide_app/core/theme/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.secondary, AppColors.primary],
      ).createShader(bounds),
      child: const CupertinoActivityIndicator(
        radius: 20,
        color: Color(0xFFFFFFFF),
      ),
    );
  }
}
