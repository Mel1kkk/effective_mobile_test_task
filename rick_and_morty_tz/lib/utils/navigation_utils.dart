import 'package:flutter/material.dart';
import 'package:rick_and_morty_tz/components/custom_appbar.dart';
import 'package:rick_and_morty_tz/components/custom_bottombar.dart';
import 'package:rick_and_morty_tz/rick_and_morty/view/favorites_screen.dart';
import 'package:rick_and_morty_tz/rick_and_morty/view/main_screen.dart';

class NavigationHandler extends StatefulWidget {
  const NavigationHandler({super.key});

  @override
  State<NavigationHandler> createState() => _MainScreenState();
}

class _MainScreenState extends State<NavigationHandler> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    MainScreen(),
    FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        title: 'Rick and Morty',
        color: Colors.white,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTabSelected: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
