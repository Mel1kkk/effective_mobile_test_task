import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTabSelected,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star_rounded),
              label: 'Favorites',
            ),
          ],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.grey.shade300,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
