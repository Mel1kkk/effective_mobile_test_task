import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_tz/rick_and_morty/view_models/characters_view_model.dart';
import 'package:rick_and_morty_tz/rick_and_morty/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CharactersViewModel())
      ],
      child: MaterialApp(
        title: 'Rick and Morty',
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


