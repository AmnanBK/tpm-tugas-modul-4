import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400, // lebar card maksimal
          ),
          child: Card(
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
                    "Kelompok Berapa Kita Ges",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(),
                  Text("123230058 / Cindy Nabella Susanto"),
                  SizedBox(height: 6),
                  Text("123230064 / Sachio Devana Putera Manildra Pasaribu"),
                  SizedBox(height: 6),
                  Text("123230078 / Amnan Budi Kusuma"),
                  SizedBox(height: 6),
                  Text("123230109 / Al Faarray"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}