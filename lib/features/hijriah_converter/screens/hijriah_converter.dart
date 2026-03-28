import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import '../../../core/theme/app_colors.dart';

class HijriahConverterScreen extends StatefulWidget {
  const HijriahConverterScreen({super.key});

  @override
  State<HijriahConverterScreen> createState() => _HijriahConverterScreenState();
}

class _HijriahConverterScreenState extends State<HijriahConverterScreen> {
  DateTime _selectedDate = DateTime.now();
  String _hijriResult = "";

  @override
  void initState() {
    super.initState();
    _convertDate(_selectedDate);
  }

  void _convertDate(DateTime date) {
    try {
      final hijriDate = HijriCalendar.fromDate(date);

      setState(() {
        _selectedDate = date;
        _hijriResult = hijriDate.toFormat("dd MMMM yyyy");
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Gagal mengonversi tanggal. Silakan coba lagi."),
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1937, 1, 1),
      lastDate: DateTime(2077, 12, 31),
    );
    if (picked != null && picked != _selectedDate) {
      _convertDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Konversi Hijriah")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Tanggal Masehi terpilih:",
                style: TextStyle(color: AppColors.textPrimary, fontSize: 20),
              ),
              const SizedBox(height: 18),
              Text(
                "${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: const Text(
                  "Pilih Tanggal Masehi",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Hasil Konversi Hijriah:",
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight(600),
                  fontSize: 18,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.secondary),
                ),
                child: Text(
                  _hijriResult,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
