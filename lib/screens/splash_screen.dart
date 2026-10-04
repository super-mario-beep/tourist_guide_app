import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/camping_image.png'),
              const SizedBox(height: 40),
              Lottie.asset(
                'assets/animations/loading_dots.json',
                width: 140,
                height: 140,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
