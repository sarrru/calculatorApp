import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  String currentInput = '';
  int first = 0;
  int second = 0;
  String operator = '';

  // List of symbols for the calculator buttons
  List<String> lstSymbols = [
    "C",
    "*",
    "/",
    "<-",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "%",
    "0",
    ".",
    "=",
  ];

  void _onButtonPressed(String symbol) {
    setState(() {
      if (symbol == "C") {
        // Clear all
        currentInput = '';
        first = 0;
        second = 0;
        operator = '';
      } else if (symbol == "<-") {
        // Remove last character
        currentInput = currentInput.isNotEmpty
            ? currentInput.substring(0, currentInput.length - 1)
            : '';
      } else if ("+-*/%".contains(symbol)) {
        // Store the first number and operator
        if (currentInput.isNotEmpty) {
          first = int.tryParse(currentInput) ?? 0;
          operator = symbol;
          currentInput = '';
        }
      } else if (symbol == "=") {
        // Perform calculation
        if (operator.isNotEmpty && currentInput.isNotEmpty) {
          second = int.tryParse(currentInput) ?? 0;
          currentInput = _calculateResult().toString();
          first = 0;
          second = 0;
          operator = '';
        }
      } else {
        // Append number or decimal
        currentInput += symbol;
      }
      _textController.text = currentInput;
    });
  }

  int _calculateResult() {
    switch (operator) {
      case "+":
        return first + second;
      case "-":
        return first - second;
      case "*":
        return first * second;
      case "/":
        return second != 0 ? first ~/ second : 0; // Integer division
      case "%":
        return second != 0 ? first % second : 0;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Display for the calculator
            TextFormField(
              textDirection: TextDirection.rtl,
              controller: _textController,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // GridView for calculator buttons
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: lstSymbols.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: () {
                      // Call the button press handler
                      _onButtonPressed(lstSymbols[index]);
                    },
                    child: Text(
                      lstSymbols[index],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
