import 'package:flutter/material.dart';

class Mycal extends StatefulWidget {
  const Mycal({Key? key});

  @override
  _MycalState createState() => _MycalState();
}

class _MycalState extends State<Mycal> {
  String displayText = '0';

  bool isCalculating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment(0.0, -1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calculate_rounded,
                  size: 30,
                  color: Colors.brown,
                ),
                SizedBox(width: 5),
                Text(
                  "MY CALCULATOR",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                displayText,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      buildButton('C', 2),
                      buildButton('⌫', 2),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('7', 2),
                      buildButton('8', 2),
                      buildButton('9', 2),
                      buildOperatorButton('÷', 2),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('4', 2),
                      buildButton('5', 2),
                      buildButton('6', 2),
                      buildOperatorButton('×', 2),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('1', 2),
                      buildButton('2', 2),
                      buildButton('3', 2),
                      buildOperatorButton('-', 2),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('0', 4), // ปรับความยาวของปุ่ม 0 เท่ากับ 4
                      buildOperatorButton('+', 2),
                    ],
                  ),
                  Row(
                    children: [
                      buildOperatorButton('=', 3),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(String text, [int widthFactor = 1]) {
    double width = (text == '0') ? 3.0 * widthFactor : 1.0 * widthFactor; 
    Color buttonColor =
        (text == 'C' || text == '⌫' || text == '=') ? const Color.fromARGB(255, 209, 201, 201) : Color.fromARGB(255, 255, 172, 17);

    return Expanded(
      child: InkWell(
        onTap: () {
          handleButtonPress(text);
        },
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(0),
              border: Border.all(color: Colors.white),
              color: buttonColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.white10,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOperatorButton(String operator, [int widthFactor = 1]) {
    double width = (operator == '+') ? 1.0 * widthFactor : 1.0 * widthFactor; 
    Color buttonColor =
        (operator == '=') ? Color.fromARGB(255, 165, 106, 85) : Color.fromARGB(255, 209, 201, 201);

    return Expanded(
      child: InkWell(
        onTap: () {
          handleButtonPress(operator);
        },
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(0),
              border: Border.all(color: Colors.white),
              color: buttonColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.white10,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                operator,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handleButtonPress(String value) async {
    if (isCalculating) return;

    setState(() {
      isCalculating = true;
    });

    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      if (value == 'C') {
        displayText = '0';
      } else if (value == '⌫') {
        if (displayText.length > 1) {
          displayText = displayText.substring(0, displayText.length - 1);
        } else {
          displayText = '0';
        }
      } else if (value == '=') {
        //try {
        //  var result = evaluateExpression(displayText);
        //  displayText = result.toString();
       // } catch (e) {
          displayText = '0';
       // }
      } else {
        if (displayText == '0' && !'+-×÷'.contains(value)) {
          displayText = value;
        } else {
          
          if ('+-×÷'.contains(displayText[displayText.length - 1]) &&
              '+-×÷'.contains(value)) {
            displayText =
                displayText.substring(0, displayText.length - 1) + value;
          } else {
            displayText += value;
          }
        }
      }
    });

    setState(() {
      isCalculating = false;
    });
  }

  double evaluateExpression(String expression) {
    return double.parse(expression);
  }
}

