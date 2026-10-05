import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tourist_guide_app/core/widgets/bottom_nav_bar.dart';
import 'package:tourist_guide_app/features/favorites/presentation/favorites_screen.dart';
import 'package:tourist_guide_app/features/places/presentation/home_screen.dart';
import 'package:tourist_guide_app/features/profile/presentation/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        // IndexedStack keeps every tab alive, so scroll position and state
        // survive switching tabs.
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeScreen(),
            FavoritesScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      ),
    );
  }
}
