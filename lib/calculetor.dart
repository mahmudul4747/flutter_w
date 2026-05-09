import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

//void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Calculator(),
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";

  // Eval function
  void equalPressed() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(userInput.replaceAll('×', '*').replaceAll('÷', '/'));
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        result = eval.toString();
      });
    } catch (e) {
      setState(() {
        result = "Error";
      });
    }
  }

  // Button Widget
  Widget button(String text, {Color bgColor = const Color(0xFF2A2A2A), Color textColor = Colors.white}) {
    return InkWell(
      onTap: () {
        setState(() {
          if (text == "AC") {
            userInput = "";
            result = "0";
          } else if (text == "⌫") {
            userInput = userInput.isNotEmpty ? userInput.substring(0, userInput.length - 1) : "";
          } else if (text == "=") {
            equalPressed();
          } else {
            userInput += text;
          }
        });
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(45),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 26, color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> buttons = [
      "AC", "⌫", "÷", "×",
      "7", "8", "9", "−",
      "4", "5", "6", "+",
      "1", "2", "3", "=",
      "0", ".", "00", "%",
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Display
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(userInput, style: const TextStyle(fontSize: 32, color: Colors.white70)),
                    const SizedBox(height: 10),
                    Text(result, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),

            // Buttons Grid
            Expanded(
              flex: 2,
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  String btn = buttons[index];

                  // Empty placeholder
                  if (btn.isEmpty) return const SizedBox();

                  // Operator buttons color
                  bool isOperator = ["+", "−", "×", "÷", "="].contains(btn);

                  return button(
                    btn,
                    bgColor: isOperator ? const Color.fromARGB(255, 37, 240, 30) : const Color(0xFF2A2A2A),
                    textColor: isOperator ? Colors.white : Colors.white70,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
