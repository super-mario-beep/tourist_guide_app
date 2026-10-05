import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide_app/core/di/service_locator.dart';
import 'package:tourist_guide_app/core/theme/app_colors.dart';
import 'package:tourist_guide_app/features/auth/presentation/splash_screen.dart';
import 'package:tourist_guide_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tourist Guide',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.background,
          onSurface: AppColors.text,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
