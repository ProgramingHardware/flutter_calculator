import 'package:flutter/material.dart';
import 'package:flutter_tutorial/widgets/calculator_button.dart';

class CalculatorPage extends StatefulWidget {
  CalculatorPage({
    super.key,
    required bool isDarkTheme,
    required this.updateTheme,
  });

  late bool isDarkTheme = false;
  late ValueChanged<bool> updateTheme;

  @override
  State<CalculatorPage> createState() =>
      // ignore: no_logic_in_create_state
      _CalculatorPageState(isDarkTheme, updateTheme);
}

class _CalculatorPageState extends State<CalculatorPage> {
  bool isDarkTheme;
  ValueChanged<bool> updateTheme;

  late String number1 = "0";
  late String number2 = "0";
  late bool isFirstNumber = true;
  late String symbol = '';

  _CalculatorPageState(this.isDarkTheme, this.updateTheme);

  @override
  Widget build(BuildContext context) {
    int fontSize = 32;
    double borderRadius = 24.0;
    int numberFormat = 1000000000;

    void clear(String value) {
      setState(() {
        number1 = "0";
        number2 = "0";
        isFirstNumber = true;
      });
    }

    void addValue(String value) {
      setState(() {
        if (isFirstNumber) {
          if (value == "." && number1.contains(".")) return;
          if (number1 == "0" && value != ".") number1 = "";
          number1 += value;
        } else {
          if (number2 == "0" && value != ".") number2 = "";
          number2 += value;
        }
      });
    }

    void plus(String value) {
      setState(() {
        if (!isFirstNumber) {
          double num1 = double.parse(number1);
          double num2 = double.parse(number2);

          num1 += num2;

          number1 = num1.toString();
          number2 = "0";
        }

        symbol = '+';
        isFirstNumber = false;
      });
    }

    void minus(String value) {
      setState(() {
        if (!isFirstNumber) {
          double num1 = double.parse(number1);
          double num2 = double.parse(number2);

          num1 -= num2;

          number1 = num1.toString();
          number2 = "0";
        }

        symbol = '-';
        isFirstNumber = false;
      });
    }

    void multiply(String value) {
      setState(() {
        if (!isFirstNumber) {
          double num1 = double.parse(number1);
          double num2 = double.parse(number2);

          num1 *= num2;

          number1 = num1.toString();
          number2 = "0";
        }

        symbol = '*';
        isFirstNumber = false;
      });
    }

    void division(String value) {
      setState(() {
        if (!isFirstNumber) {
          double num1 = double.parse(number1);
          double num2 = double.parse(number2);

          num1 /= num2;

          number1 = num1.toString();
          number2 = "0";
        }

        symbol = '/';
        isFirstNumber = false;
      });
    }

    void percentage(String value) {
      setState(() {
        if (isFirstNumber) {
          double num1 = double.parse(number1);
          num1 *= 0.01;
          number1 = num1.toInt() == num1
              ? num1.toInt().toString()
              : ((num1 * numberFormat).toInt().toDouble() / numberFormat)
                  .toString();
        } else {
          double num1 = double.parse(number1);
          double num2 = double.parse(number2);

          if (symbol == "+")
            num1 += (num2 * 0.01) * num1;
          else if (symbol == "-")
            num1 -= (num2 * 0.01) * num1;
          else if (symbol == "*")
            num1 *= (num2 / 100);
          else if (symbol == "/") num1 /= (num2 / 100);

          number1 = num1.toInt() == num1
              ? num1.toInt().toString()
              : ((num1 * numberFormat).toInt().toDouble() / numberFormat)
                  .toString();
          number2 = "0";
          isFirstNumber = true;
        }
      });
    }

    void rotateNumber(String value) {
      setState(() {
        if (isFirstNumber) {
          if (number1.startsWith("-"))
            number1 = number1.substring(1);
          else
            number1 = "-" + number1;
        } else {
          if (number2.startsWith("-"))
            number2 = number2.substring(1);
          else
            number2 = "-" + number2;
        }
      });
    }

    void equal(String value) {
      setState(() {
        if (symbol == "+") {
          isFirstNumber = true;
          double num1 = double.parse(number1);
          double num2 = double.parse(number2);

          num1 += num2;
          number1 = num1.toInt() == num1
              ? num1.toInt().toString()
              : ((num1 * numberFormat).toInt().toDouble() / numberFormat)
                  .toString();
          number2 = "0";
        } else if (symbol == "-") {
          isFirstNumber = true;
          double num1 = double.parse(number1);
          double num2 = double.parse(number2);

          num1 -= num2;
          number1 = num1.toInt() == num1
              ? num1.toInt().toString()
              : ((num1 * numberFormat).toInt().toDouble() / numberFormat)
                  .toString();
          number2 = "0";
        } else if (symbol == "*") {
          isFirstNumber = true;
          double num1 = double.parse(number1);
          double num2 = double.parse(number2);

          num1 *= num2;
          number1 = num1.toInt() == num1
              ? num1.toInt().toString()
              : ((num1 * numberFormat).toInt().toDouble() / numberFormat)
                  .toString();
          number2 = "0";
        } else if (symbol == "/") {
          isFirstNumber = true;
          double num1 = double.parse(number1);
          double num2 = double.parse(number2);

          num1 /= num2;
          number1 = num1.toInt() == num1
              ? num1.toInt().toString()
              : ((num1 * numberFormat).toInt().toDouble() / numberFormat)
                  .toString();
          number2 = "0";
        }
      });
    }

    void backspace(String value) {
      setState(() {
        if (isFirstNumber) {
          number1 = number1.substring(0, number1.length - 1);
          if (number1.isEmpty) number1 = "0";
        } else {
          number2 = number2.substring(0, number2.length - 1);
          if (number2.isEmpty) number2 = "0";
        }
      });
    }

    String value() {
      return isFirstNumber ? number1 : number2;
    }

    String secondValue() {
      return isFirstNumber ? "" : "$number1$symbol";
    }

    return Scaffold(
      // backgroundColor: isDarkTheme ? const Color.fromARGB(255, 23, 23, 28) : const Color.fromARGB(255, 241, 242, 243),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Switch(
            value: isDarkTheme,
            onChanged: (bool newBool) {
              setState(() {
                isDarkTheme = newBool;
                updateTheme(newBool);
              });
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                secondValue(),
                style: TextStyle(
                  fontSize: 40,
                  color: isDarkTheme
                      ? const Color.fromARGB(255, 116, 116, 119)
                      : const Color.fromARGB(102, 0, 0, 0),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                value(),
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize:
                      96.0 - value().length * 2.8 > 40 && value().length > 8
                          ? 96.0 - value().length - 8 * 2.8
                          : value().length > 8
                              ? 40
                              : 96,
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              bottom: 10.0,
            ),
            child: SizedBox(
              height: 560,
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  // ********** Row **********
                  CalculatorButton(
                    backgroundColor: isDarkTheme
                        ? const Color.fromARGB(255, 78, 80, 95)
                        : const Color.fromARGB(255, 210, 211, 218),
                    borderRadius: borderRadius,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    text: 'C',
                    isIconButton: false,
                    isImageButton: false,
                    icon: const Icon(Icons.backspace_rounded),
                    isLightIcon: !isDarkTheme,
                    addValue: clear,
                  ),
                  CalculatorButton(
                    backgroundColor: isDarkTheme
                        ? const Color.fromARGB(255, 78, 80, 95)
                        : const Color.fromARGB(255, 210, 211, 218),
                    borderRadius: borderRadius,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    text: '±',
                    isIconButton: true,
                    isImageButton: true,
                    icon: const Icon(Icons.backspace_rounded),
                    lightImage: Image.asset('images/plus-minus-light.png'),
                    darkImage: Image.asset('images/plus-minus-dark.png'),
                    isLightIcon: !isDarkTheme,
                    addValue: rotateNumber,
                  ),
                  CalculatorButton(
                    backgroundColor: isDarkTheme
                        ? const Color.fromARGB(255, 78, 80, 95)
                        : const Color.fromARGB(255, 210, 211, 218),
                    borderRadius: borderRadius,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    text: '%',
                    isIconButton: false,
                    isImageButton: false,
                    icon: const Icon(Icons.backspace_rounded),
                    isLightIcon: !isDarkTheme,
                    addValue: percentage,
                  ),
                  CalculatorButton(
                    backgroundColor: const Color.fromARGB(255, 75, 94, 252),
                    borderRadius: borderRadius,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    text: '÷',
                    isIconButton: false,
                    isImageButton: false,
                    icon: const Icon(Icons.backspace_rounded),
                    isLightIcon: false,
                    addValue: division,
                  ),
                  // ********** Row **********
                  CalculatorButton(
                    backgroundColor: isDarkTheme
                        ? const Color.fromARGB(255, 46, 47, 56)
                        : const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: borderRadius,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    text: '7',
                    isIconButton: false,
                    isImageButton: false,
                    icon: const Icon(Icons.backspace_rounded),
                    isLightIcon: !isDarkTheme,
                    addValue: addValue,
                  ),
                  CalculatorButton(
                    backgroundColor: isDarkTheme
                        ? const Color.fromARGB(255, 46, 47, 56)
                        : const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: borderRadius,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    text: '8',
                    isIconButton: false,
                    isImageButton: false,
                    icon: const Icon(Icons.backspace_rounded),
                    isLightIcon: !isDarkTheme,
                    addValue: addValue,
                  ),
                  CalculatorButton(
                    backgroundColor: isDarkTheme
                        ? const Color.fromARGB(255, 46, 47, 56)
                        : const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: borderRadius,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    text: '9',
                    isIconButton: false,
                    isImageButton: false,
                    icon: const Icon(Icons.backspace_rounded),
                    isLightIcon: !isDarkTheme,
                    addValue: addValue,
                  ),
                  CalculatorButton(
                    backgroundColor: const Color.fromARGB(255, 75, 94, 252),
                    borderRadius: borderRadius,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    text: '×',
                    isIconButton: false,
                    isImageButton: false,
                    icon: const Icon(Icons.backspace_rounded),
                    isLightIcon: false,
                    addValue: multiply,
                  ),
                  // // ********** Row **********
                  CalculatorButton(
                    backgroundColor: isDarkTheme
                        ? const Color.fromARGB(255, 46, 47, 56)
                        : const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: borderRadius,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    text: '4',
                    isIconButton: false,
                    isImageButton: false,
                    icon: const Icon(Icons.backspace_rounded),
                    isLightIcon: !isDarkTheme,
                    addValue: addValue,
                  ),
                  CalculatorButton(
                    backgroundColor: isDarkTheme
                        ? const Color.fromARGB(255, 46, 47, 56)
                        : const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: borderRadius,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    text: '5',
                    isIconButton: false,
                    isImageButton: false,
                    icon: const Icon(Icons.backspace_rounded),
                    isLightIcon: !isDarkTheme,
                    addValue: addValue,
                  ),
                  CalculatorButton(
                    backgroundColor: isDarkTheme
                        ? const Color.fromARGB(255, 46, 47, 56)
                        : const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: borderRadius,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    text: '6',
                    isIconButton: false,
                    isImageButton: false,
                    icon: const Icon(Icons.backspace_rounded),
                    isLightIcon: !isDarkTheme,
                    addValue: addValue,
                  ),
                  CalculatorButton(
                    backgroundColor: const Color.fromARGB(255, 75, 94, 252),
                    borderRadius: borderRadius,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    text: '-',
                    isIconButton: false,
                    isImageButton: false,
                    icon: const Icon(Icons.backspace_rounded),
                    isLightIcon: false,
                    addValue: minus,
                  ),
                  // ********** Row **********
                  CalculatorButton(
                    backgroundColor: isDarkTheme
                        ? const Color.fromARGB(255, 46, 47, 56)
                        : const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: borderRadius,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    text: '1',
                    isIconButton: false,
                    isImageButton: false,
                    icon: const Icon(Icons.backspace_rounded),
                    isLightIcon: !isDarkTheme,
                    addValue: addValue,
                  ),
                  CalculatorButton(
                    backgroundColor: isDarkTheme
                        ? const Color.fromARGB(255, 46, 47, 56)
                        : const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: borderRadius,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    text: '2',
                    isIconButton: false,
                    isImageButton: false,
                    icon: const Icon(Icons.backspace_rounded),
                    isLightIcon: !isDarkTheme,
                    addValue: addValue,
                  ),
                  CalculatorButton(
                    backgroundColor: isDarkTheme
                        ? const Color.fromARGB(255, 46, 47, 56)
                        : const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: borderRadius,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    text: '3',
                    isIconButton: false,
                    isImageButton: false,
                    icon: const Icon(Icons.backspace_rounded),
                    isLightIcon: !isDarkTheme,
                    addValue: addValue,
                  ),
                  CalculatorButton(
                    backgroundColor: const Color.fromARGB(255, 75, 94, 252),
                    borderRadius: borderRadius,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    text: '+',
                    isIconButton: false,
                    isImageButton: false,
                    icon: const Icon(Icons.backspace_rounded),
                    isLightIcon: false,
                    addValue: plus,
                  ),
                  // ********** Row **********
                  CalculatorButton(
                    backgroundColor: isDarkTheme
                        ? const Color.fromARGB(255, 46, 47, 56)
                        : const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: borderRadius,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    text: '.',
                    isIconButton: false,
                    isImageButton: false,
                    icon: const Icon(Icons.backspace_rounded),
                    isLightIcon: !isDarkTheme,
                    addValue: addValue,
                  ),
                  CalculatorButton(
                    backgroundColor: isDarkTheme
                        ? const Color.fromARGB(255, 46, 47, 56)
                        : const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: borderRadius,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    text: '0',
                    isIconButton: false,
                    isImageButton: false,
                    icon: const Icon(Icons.backspace_rounded),
                    isLightIcon: !isDarkTheme,
                    addValue: addValue,
                  ),
                  CalculatorButton(
                    backgroundColor: isDarkTheme
                        ? const Color.fromARGB(255, 46, 47, 56)
                        : const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: borderRadius,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    text: 'del',
                    isIconButton: true,
                    isImageButton: false,
                    icon: const Icon(Icons.backspace_outlined),
                    isLightIcon: !isDarkTheme,
                    addValue: backspace,
                  ),
                  CalculatorButton(
                    backgroundColor: const Color.fromARGB(255, 75, 94, 252),
                    borderRadius: borderRadius,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    text: '=',
                    isIconButton: false,
                    isImageButton: false,
                    icon: const Icon(Icons.backspace_rounded),
                    isLightIcon: false,
                    addValue: equal,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
