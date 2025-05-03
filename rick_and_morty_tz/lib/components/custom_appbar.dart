import 'package:flutter/material.dart';
import 'package:rick_and_morty_tz/rick_and_morty/repo/local/local_database.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color color;
  
  const CustomAppbar({super.key, required this.title, required this.color});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: color,
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () async {
            await LocalDatabase().clearCharacters();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Кэш очищен'),
                  duration: Duration(seconds: 1),
              ));
            }
          },
        ),
      ],
    );
  }
}


