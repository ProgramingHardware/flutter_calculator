import 'package:flutter/material.dart';
import 'package:flutter_tutorial/calculator_view.dart';

void main() {
  runApp(const MaterialView());
}

class MaterialView extends StatefulWidget {
  const MaterialView({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<MaterialView> createState() => _MaterialViewState();
}

class _MaterialViewState extends State<MaterialView> {
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 241, 242, 243),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color.fromARGB(255, 23, 23, 28),
      ),
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: CalculatorPage(
        isDarkTheme: isDarkTheme,
        updateTheme: (bool isDarkTheme) {
          setState(() {
            this.isDarkTheme = isDarkTheme;
          });
        },
      ),
    );
  }
}
