import 'package:flutter/material.dart';
import 'package:tourist_guide_app/core/theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _iconSize = 32.0;
  static const _inactiveColor = Color(0xFFD9D9D9);
  static const _labelStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const _items = [
    (icon: Icons.home_rounded, label: 'Home'),
    (icon: Icons.favorite_rounded, label: 'Favorites'),
    (icon: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, -2),
            blurRadius: 20,
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconSize: _iconSize,
        selectedItemColor: AppColors.text,
        unselectedItemColor: AppColors.text,
        selectedFontSize: _labelStyle.fontSize!,
        unselectedFontSize: _labelStyle.fontSize!,
        selectedLabelStyle: _labelStyle,
        unselectedLabelStyle: _labelStyle,
        items: [
          for (final item in _items)
            BottomNavigationBarItem(
              icon: Icon(item.icon, color: _inactiveColor),
              activeIcon: _GradientIcon(item.icon),
              label: item.label,
            ),
        ],
      ),
    );
  }
}

class _GradientIcon extends StatelessWidget {
  const _GradientIcon(this.icon);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [AppColors.primary, AppColors.secondary],
      ).createShader(bounds),
      child: Icon(icon, color: Colors.white),
    );
  }
}
