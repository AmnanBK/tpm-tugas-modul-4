import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class AgeCalculatorScreen extends StatefulWidget {
  const AgeCalculatorScreen({super.key});

  @override
  State<AgeCalculatorScreen> createState() => _AgeCalculatorScreenState();
}

class _AgeCalculatorScreenState extends State<AgeCalculatorScreen> {
  DateTime selectedDate = DateTime.now();
  String result = "Pilih Waktu Lahir";

  Future<void> pickDateTime() async {
    // 1. Pick Date
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      // 2. Pick Time
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime fullBirthDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        _calculateDetailedAge(fullBirthDate);
      }
    }
  }

  void _calculateDetailedAge(DateTime birth) {
    DateTime now = DateTime.now();
    if (birth.isAfter(now)) {
      setState(() => result = "Waktu Tidak Valid");
      return;
    }

    Duration diff = now.difference(birth);
    int years = now.year - birth.year;
    int months = now.month - birth.month;
    int days = now.day - birth.day;

    if (days < 0) {
      months -= 1;
      days += DateTime(now.year, now.month, 0).day;
    }
    if (months < 0) {
      years -= 1;
      months += 12;
    }

    int hours = diff.inHours % 24;
    int minutes = diff.inMinutes % 60;

    setState(() {
      selectedDate = birth;
      result =
          "$years Thn, $months Bln, $days Hari\n$hours Jam, $minutes Menit";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("Hitung Umur")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Card(
              color: AppColors.surface,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Hitung Umur Presisi",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Waktu Lahir Terpilih:",
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      // Format tampilan Tanggal dan Jam
                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}  ${selectedDate.hour.toString().padLeft(2, '0')}:${selectedDate.minute.toString().padLeft(2, '0')}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: pickDateTime,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text("Set Tanggal & Jam"),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity, // Biar kotaknya penuh ke samping
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.secondary),
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center, // Hasil di tengah
                        children: [
                          const Icon(
                            Icons.timer_outlined,
                            color: AppColors.secondary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              result,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
