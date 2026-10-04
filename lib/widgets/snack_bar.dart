import 'package:flutter/material.dart';
import 'package:tourist_guide_app/theme/app_colors.dart';

extension SnackBarContext on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: _SlideInFromRight(
            child: _SnackBarContent(message: message),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          clipBehavior: Clip.none,
        ),
        // The built-in animation grows the snack bar from the bottom;
        // it's disabled so only the slide below is visible.
        snackBarAnimationStyle: AnimationStyle.noAnimation,
      );
  }
}

class _SlideInFromRight extends StatelessWidget {
  const _SlideInFromRight({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: const Offset(1.2, 0), end: Offset.zero),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      builder: (_, offset, child) =>
          FractionalTranslation(translation: offset, child: child),
      child: child,
    );
  }
}

class _SnackBarContent extends StatelessWidget {
  const _SnackBarContent({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 69),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: AppColors.secondary, width: 3),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Text(
        message,
        style: const TextStyle(
          color: AppColors.text,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
