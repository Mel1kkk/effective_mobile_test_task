import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rick_and_morty_tz/utils/navigation_utils.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Lottie.asset(
          'assets/animation/splash_rick.json',
        ),
      ),
      nextScreen: const NavigationHandler(),
      duration: 2500,
      backgroundColor: Colors.white,
      splashIconSize: 400,
      splashTransition: SplashTransition.sizeTransition,
    );
  }
}