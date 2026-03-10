import 'package:flutter/material.dart';
import 'core/theme/app_colors.dart';
import 'features/auth/screens/login_screen.dart';

void main() {
  runApp(const MathUtilityApp());
}

class MathUtilityApp extends StatelessWidget {
  const MathUtilityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Utility App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
