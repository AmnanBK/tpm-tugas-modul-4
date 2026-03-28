import 'package:flutter/material.dart';
import 'package:tpm_tugas_modul_4/features/hijriah_converter/screens/hijriah_converter.dart';
import '../../stopwatch/screens/stopwatch_screen.dart';
import '../../group_profile/screens/profile_screen.dart';
import '../../calculator/screens/calculator_screen.dart';
import '../../number_checker/screens/checker_screen.dart';
import '../../pyramid/screens/pyramid_screen.dart';
import '../../field_counter/screens/field_counter_screen.dart';
import '../../../core/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [_buildMainMenu(), const ProfileScreen()];

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? 'Menu Utama' : 'Profil Kelompok'),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Profil'),
        ],
      ),
    );
  }

  // KOMPONEN LOKAL (Hanya dipakai di layar ini)

  Widget _buildMainMenu() {
    // Daftar nama fitur untuk di-looping menjadi tombol
    final List<String> features = [
      'Kalkulator',
      'Cek Angka',
      'Total Digit',
      'Stopwatch',
      'Piramida',
      'Konversi Hijriah',
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.2,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            // TODO: Tambahkan navigasi ke layar masing-masing (Navigator.push)
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text('Menuju fitur ${features[index]}...')),
            // );

            if (features[index] == 'Stopwatch') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StopwatchScreen(),
                ),
              );
            } else if (features[index] == 'Kalkulator') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CalculatorScreen(),
                ),
              );
            } else if (features[index] == 'Cek Angka') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CheckerScreen()),
              );
            } else if (features[index] == 'Piramida') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PyramidScreen()),
              );
            } else if (features[index] == 'Total Digit') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FieldCounterScreen(),
                ),
              );
            } else if (features[index] == 'Konversi Hijriah') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HijriahConverterScreen(),
                ),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                features[index],
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
