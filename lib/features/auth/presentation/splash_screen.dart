import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tourist_guide_app/core/di/service_locator.dart';
import 'package:tourist_guide_app/features/auth/presentation/sign_in_screen.dart';
import 'package:tourist_guide_app/features/auth/presentation/splash_view_model.dart';
import 'package:tourist_guide_app/features/main/presentation/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _viewModel = SplashViewModel(getIt());

  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    final isSignedIn = await _viewModel.isSignedIn();
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) =>
            isSignedIn ? const MainScreen() : const SignInScreen(),
      ),
    );
  }

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
