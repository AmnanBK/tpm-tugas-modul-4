import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class FieldCounterScreen extends StatefulWidget {
  const FieldCounterScreen({super.key});

  @override
  State<FieldCounterScreen> createState() => _FieldCounterScreenState();
}

class _FieldCounterScreenState extends State<FieldCounterScreen> {
  final TextEditingController _numberController = TextEditingController();
  String _result = 'Jumlah digit: 0';

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  void _updateDigits(String input) {
    final digits = input.replaceAll(RegExp(r'[^0-9]'), '');
    final count = digits.length;
    setState(() {
      _result = 'Jumlah digit: $count';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Total Digit')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Hitung Jumlah Digit Angka',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Masukkan angka',
                hintText: 'Contoh: 12345 atau 123.45',
              ),
              onChanged: _updateDigits,
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _result,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
