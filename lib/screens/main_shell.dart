import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_nav.dart';
import 'home/home_screen.dart';
import 'search/search_screen.dart';
import 'library/library_screen.dart';
import 'wishlist/wishlist_screen.dart';
import 'profile/profile_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentTabIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(onNavigateTab: _onTabSelected),
      const SearchScreen(),
      const LibraryScreen(),
      const WishlistScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentTabIndex,
        children: screens,
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentTabIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
