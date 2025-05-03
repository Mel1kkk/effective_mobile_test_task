import 'package:flutter/material.dart';

class BoldTitle extends StatelessWidget {
  final String name;
  final Color color;

  const BoldTitle({super.key, required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      textAlign: TextAlign.center,
      softWrap: true,
      overflow: TextOverflow.visible,
      style: TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.w600
      ),
    );
  }
}