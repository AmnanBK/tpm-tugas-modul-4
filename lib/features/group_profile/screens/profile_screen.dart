import 'package:flutter/material.dart';
import '/../../core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          child: Card(
            color: AppColors.surface,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Kelompok PMT",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Divider(
                    color: AppColors.textSecondary,
                  ),
                  Text(
                    "123230058 / Cindy Nabella Susanto",
                    style: TextStyle(color: AppColors.textPrimary),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "123230064 / Sachio Devana Putera Manildra Pasaribu",
                    style: TextStyle(color: AppColors.textPrimary),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "123230078 / Amnan Budi Kusuma",
                    style: TextStyle(color: AppColors.textPrimary),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "123230109 / Al Faarray",
                    style: TextStyle(color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}