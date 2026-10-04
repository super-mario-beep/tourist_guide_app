import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tourist_guide_app/screens/home_screen.dart';
import 'package:tourist_guide_app/screens/profile_screen.dart';
import 'package:tourist_guide_app/widgets/bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const _favoritesTab = 1;

  int _currentIndex = 0;

  void _onTabTapped(int index) {
    // Favorites screen doesn't exist yet.
    if (index == _favoritesTab) return;
    setState(() => _currentIndex = index);
  }

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
            SizedBox.shrink(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
        ),
      ),
    );
  }
}
