import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  final input = TextEditingController();
  final output = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      // appBar: AppBar(
      //   backgroundColor: Colors.grey.shade100,
      //   elevation: 0,
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     icon: const Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.black,
      //     ),
      //   ),
      // ),

      body: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextField(
              controller: input,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '',
              ),
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: output,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '',
              ),
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                button(
                    text: 'AC',
                    btnColor: Colors.grey[300],
                    textColor: Colors.black),
                button(
                    text: '%',
                    btnColor: Colors.grey[300],
                    textColor: Colors.black),
                button(
                    text: '⌫',
                    icon: Icons.backspace_outlined,
                    btnColor: Colors.grey[300],
                    textColor: Colors.black),
                button(
                  text: '÷',
                  btnColor: Colors.grey[300],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                button(text: '7'),
                button(text: '8'),
                button(text: '9'),
                button(
                  text: '*',
                  icon: Icons.close,
                  btnColor: Colors.grey[300],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                button(text: '4'),
                button(text: '5'),
                button(text: '6'),
                button(
                  text: '-',
                  icon: Icons.remove,
                  btnColor: Colors.grey[300],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                button(text: '1'),
                button(text: '2'),
                button(text: '3'),
                button(
                  text: '+',
                  icon: Icons.add,
                  btnColor: Colors.grey[300],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                button(text: '00'),
                button(text: '0'),
                button(text: '.'),
                button(
                  text: '=',
                  btnColor: Colors.orange.shade800,
                  textColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget button({
    required String text,
    Color? btnColor = Colors.white,
    Color? textColor = Colors.black,
    IconData? icon,
  }) {
    return GestureDetector(
      onTap: () {
        if (text == 'AC') {
          input.text = '';
          output.text = '';
        } else if (text == '÷') {
          input.text += '/';
        } else if (text == 'X') {
          input.text += '*';
        } else if (text == '=') {
          final result = eval(input.text);
          output.text = result.toString();
        } else if (text == '⌫') {
          input.text = input.text.substring(0, input.text.length - 1);
        } else if (text == '%') {
          input.text += '%';
        } else {
          input.text += text;
        }
      },
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(color: btnColor, shape: BoxShape.circle),
        child: Center(
          child: icon != null
              ? Icon(icon, color: textColor)
              : Text(
                  text,
                  style: TextStyle(
                    fontSize: 30,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }

  String eval(String expression) {
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    var e = exp.evaluate(EvaluationType.REAL, cm);
    final s = e.toString();
    return s;
  }
}
