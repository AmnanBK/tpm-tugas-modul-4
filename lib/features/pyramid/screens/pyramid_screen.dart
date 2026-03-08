import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class PyramidScreen extends StatefulWidget {
  const PyramidScreen({super.key});

  @override
  State<PyramidScreen> createState() => _PyramidScreenState();
}

class _PyramidScreenState extends State<PyramidScreen> {
  final TextEditingController _sideController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String _mode = 'Volume';
  String _result = '';

  @override
  void dispose() {
    _sideController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _calculate() {
    final a = double.tryParse(_sideController.text.replaceAll(',', '.'));
    final h = double.tryParse(_heightController.text.replaceAll(',', '.'));

    if (a == null || a <= 0) {
      _showError('Masukkan panjang sisi (a) yang valid (> 0)');
      return;
    }

    if (h == null || h <= 0) {
      _showError('Masukkan tinggi (h) yang valid (> 0)');
      return;
    }

    if (_mode == 'Volume') {
      final volume = (1 / 3) * a * a * h; // volume = 1/3 * luas alas (persegi) * tinggi
      setState(() {
        _result = 'Volume = ${volume.toStringAsFixed(4)}';
      });
    } else {
      final slant = sqrt(pow(a / 2, 2) + pow(h, 2));
      final baseArea = a * a;
      final lateralArea = 2 * a * slant; // luas sisi miring
      final surface = baseArea + lateralArea;
      setState(() {
        _result = 'Luas permukaan = ${surface.toStringAsFixed(4)}';
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Pyramid Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Hitung Luas & Volume Piramid (Persegi)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _mode,
              items: const [
                DropdownMenuItem(value: 'Volume', child: Text('Volume')),
                DropdownMenuItem(value: 'Surface', child: Text('Luas Permukaan')),
              ],
              onChanged: (v) {
                if (v != null) {
                  setState(() {
                    _mode = v == 'Surface' ? 'Surface' : 'Volume';
                    _result = '';
                  });
                }
              },
              decoration: const InputDecoration(labelText: 'Pilih perhitungan'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _sideController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Panjang sisi alas (a)'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Tinggi piramid (h)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _calculate, child: const Text('Hitung')),
            const SizedBox(height: 20),
            if (_result.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _result,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
