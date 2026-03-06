import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController display = TextEditingController();
  final formatter = NumberFormat("#,##0.######");

  List<String> buttons = [
    '7',
    '8',
    '9',
    '+',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '⌫',
    '0',
    '.',
    'C',
    '=',
  ];

  void calculate() {
    String text = display.text.replaceAll(",", "");

    if (text.contains('+')) {
      var parts = text.split('+');

      if (parts.length == 2) {
        double a = double.tryParse(parts[0]) ?? 0;
        double b = double.tryParse(parts[1]) ?? 0;

        double result = a + b;

        display.text = formatter.format(result);
      }
    } else if (text.contains('-')) {
      var parts = text.split('-');

      if (parts.length == 2) {
        double a = double.tryParse(parts[0]) ?? 0;
        double b = double.tryParse(parts[1]) ?? 0;

        double result = a - b;

        display.text = formatter.format(result);
      }
    }

    setState(() {});
  }

  void handleButton(String value) {
    if (value == "C") {
      display.clear();
      setState(() {});
      return;
    }

    if (value == "=") {
      calculate();
      return;
    }

    if (value == "⌫") {
      if (display.text.isNotEmpty) {
        display.text = display.text.substring(0, display.text.length - 1);
      }

      setState(() {});
      return;
    }

    if (RegExp(r'[0-9]').hasMatch(value)) {
      List<String> parts = display.text.split(RegExp(r'[+\-]'));
      String lastNumber = parts.last.replaceAll(RegExp(r'[.,]'), '');

      if (lastNumber.length >= 12) {
        ScaffoldMessenger.of(context).clearSnackBars();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Maksimal 12 digit per bilangan'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );

        return;
      }
    }

    if (value == '+' || value == '-' || value == '.') {
      if (display.text.isEmpty && value != '-') {
        return;
      }

      if (display.text.isNotEmpty) {
        String lastChar = display.text[display.text.length - 1];

        if (lastChar == '+' || lastChar == '-' || lastChar == '.') {
          return;
        }
      }

      if (value == '.') {
        List<String> parts = display.text.split(RegExp(r'[+\-]'));
        String currentNumber = parts.last;

        if (currentNumber.contains('.')) {
          return;
        }
      }

      if (value == '+' || value == '-') {
        String textToSearch = display.text.length > 1
            ? display.text.substring(1)
            : "";

        if (textToSearch.contains('+') || textToSearch.contains('-')) {
          ScaffoldMessenger.of(context).clearSnackBars();
          return;
        }
      }
    }

    setState(() {
      display.text += value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Kalkulator"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: display,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 28),
              keyboardType: TextInputType.text,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-.,]')),
                CalculatorInputFormatter(),
              ],
              onSubmitted: (value) {
                calculate();
              },
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ),

          Expanded(
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                String value = buttons[index];

                Color bgColor = Colors.grey.shade200;
                Color textColor = Colors.black;

                if (value == '=') {
                  bgColor = Colors.blue;
                  textColor = Colors.white;
                }

                Widget buttonContent;
                if (value == '⌫') {
                  buttonContent = Icon(Icons.backspace_outlined, size: 24);
                } else {
                  buttonContent = Text(
                    value,
                    style: const TextStyle(fontSize: 24),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(6),

                  child: ElevatedButton(
                    onPressed: () => handleButton(value),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: bgColor,
                      foregroundColor: textColor,
                      padding: EdgeInsets.zero,
                    ),
                    child: buttonContent,
                    //child: Text(value, style: const TextStyle(fontSize: 24)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CalculatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;

    if (newText == '+' || newText == '.') {
      return oldValue; // Tolak ketikan, kembalikan ke state lama
    }

    if (RegExp(r'[+\-.]{2,}').hasMatch(newText)) {
      return oldValue;
    }

    String textToSearch = newText.length > 1 ? newText.substring(1) : "";
    int operatorCount = 0;
    for (int i = 0; i < textToSearch.length; i++) {
      if (textToSearch[i] == '+' || textToSearch[i] == '-') {
        operatorCount++;
      }
    }
    if (operatorCount > 1) {
      return oldValue;
    }

    List<String> parts = newText.split(RegExp(r'[+\-]'));
    for (String part in parts) {
      if (part.split('.').length > 2) {
        return oldValue;
      }
    }

    String lastNumber = parts.last;
    String pureDigits = lastNumber.replaceAll(RegExp(r'[.,]'), '');

    if (pureDigits.length > 12) {
      return oldValue;
    }

    return newValue;
  }
}
