import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String userInput = "";
  String result = "0";
  List<String> buttonList = [
    "C",
    "(",
    ")",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "-",
    "AC",
    "0",
    ".",
    "="
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(title: const Text("Simple Calculator")),
        body: Column(
          children: [
            Flexible(
              child: appBar(),
              flex: 1,
            ),
            Flexible(
              child: resultWidget(),
              flex: 2,
            ),
            Flexible(
              child: buttonWidget(),
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget appBar() {
    return const Text(
      "Simple Calculator",
      style: TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black87),
    );
  }

  Widget resultWidget() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerRight,
          child: Text(
            userInput,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.normal,
            ),
          ),
          color: Colors.cyanAccent,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerRight,
          child: Text(
            result,
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          color: Colors.greenAccent,
        )
      ],
    );
  }

  Widget buttonWidget() {
    return GridView.builder(
        itemCount: buttonList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, childAspectRatio: 5.4),
        itemBuilder: (BuildContext context, int index) {
          return button(buttonList[index]);
        });
  }

  Widget button(String text) {
    return Container(
      //height: MediaQuery.of(context).size.height * 0.75,
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        onPressed: () {
          setState(() {
            handleButtonPress(text);
          });
        },
        color: getColor(text),
        textColor: Colors.white,
        child: Text(
          text,
          style: TextStyle(fontSize: 25),
        ),
        shape: CircleBorder(),
      ),
    );
  }

  handleButtonPress(String text) {
    if (text == "AC") {
      //reset all
      userInput = "";
      result = "0";
      return;
    }
    if (text == "C") {
      //remove last char
      userInput = userInput.substring(0, userInput.length - 1);
      return;
    }
    if (text == "=") {
      //calculate result
      result = calculate();
      //remove decimal if .0
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
      }
      return;
    }
    userInput = userInput + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }

  getColor(String text) {
    if (text == "/" || text == "*" || text == "+" || text == "-") {
      return Colors.orangeAccent;
    }
    if (text == "C" || text == "AC") {
      return Colors.redAccent;
    }
    if (text == "(" || text == ")") {
      return Colors.blueGrey;
    }
    if (text == "=") {
      return Colors.green;
    }
    return Colors.lightBlue;
  }
}
