import 'package:flutter/material.dart';

class AppError extends StatelessWidget {
  final String? errortxt;

  const AppError({super.key, this.errortxt});

  @override
  Widget build(BuildContext context) {
    if (errortxt == null || errortxt!.isEmpty) {
      return SizedBox.shrink();
    }
    return Center(
      child: Text(
        errortxt!,
        style: TextStyle(
          color: Colors.red,
          fontSize: 18,
        ),
      ),
    );
  }
}