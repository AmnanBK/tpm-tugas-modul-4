import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class WetonCheckerScreen extends StatefulWidget {
  const WetonCheckerScreen({super.key});

  @override
  State<WetonCheckerScreen> createState() => _WetonCheckerScreenState();
}

class _WetonCheckerScreenState extends State<WetonCheckerScreen> {
  DateTime selectedDate = DateTime.now();
  String result = "";

  final List<String> wetonList = [
    "Legi",
    "Pahing",
    "Pon",
    "Wage",
    "Kliwon"
  ];

  @override
  void initState() {
    super.initState();
    calculateWeton();
  }

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
      calculateWeton();
    }
  }

  void calculateWeton() {
    //acuan 1 Januari 2023 adalah mingu pahing
    DateTime baseDate = DateTime(2023, 1, 1);

    int diff = selectedDate.difference(baseDate).inDays;

    int wetonIndex = (diff + 1) % 5;
    if (wetonIndex < 0) wetonIndex += 5;

    String weton = wetonList[wetonIndex];
    String dayName = getDayName(selectedDate.weekday);

    setState(() {
      result = "$dayName $weton";
    });
  }

  String getDayName(int day) {
    switch (day) {
      case 1:
        return "Senin";
      case 2:
        return "Selasa";
      case 3:
        return "Rabu";
      case 4:
        return "Kamis";
      case 5:
        return "Jumat";
      case 6:
        return "Sabtu";
      case 7:
        return "Minggu";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Weton Checker"),
      ),
      body: Center(
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
                    "Cek Weton",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Tanggal:",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: pickDate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("Pilih Tanggal"),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.secondary,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          result,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary,
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
    );
  }
}