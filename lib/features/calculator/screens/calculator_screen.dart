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
  final formatter = NumberFormat("#,##0.############");

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

                return Padding(
                  padding: const EdgeInsets.all(6),

                  child: ElevatedButton(
                    onPressed: () => handleButton(value),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: bgColor,
                      foregroundColor: textColor,
                      // elevation: 0,
                    ),

                    child: Text(value, style: const TextStyle(fontSize: 24)),
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
