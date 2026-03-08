import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/number_checker.dart';

class CheckerScreen extends StatefulWidget {
  const CheckerScreen({super.key});

  @override
  State<CheckerScreen> createState() => _CheckerScreenState();
}

class _CheckerScreenState extends State<CheckerScreen> {

  final TextEditingController _controller = TextEditingController();

  String parityResult = "";
  String primeResult = "";

  void checkNumber() {
    int? number = int.tryParse(_controller.text);

    if (number == null) {
      setState(() {
        parityResult = "Input tidak valid";
        primeResult = "";
      });
      return;
    }

    bool isEven = NumberChecker.isEven(number);
    bool isPrime = NumberChecker.isPrime(number);

    setState(() {
      parityResult = isEven ? "Genap" : "Ganjil";
      primeResult = isPrime ? "Bilangan Prima" : "Bukan Bilangan Prima";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Cek Angka"),
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
                    "Number Checker",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,

                    decoration: const InputDecoration(
                      labelText: "Masukkan Angka",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: checkNumber,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),

                    child: const Text("Check"),
                  ),

                  const SizedBox(height: 20),

                  if (parityResult.isNotEmpty)
                    Text(
                      parityResult,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),

                  if (primeResult.isNotEmpty)
                    Text(
                      primeResult,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
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