import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  CalculatorButton({
    super.key,
    required this.backgroundColor,
    required this.text,
    required this.icon,
    this.lightImage,
    this.darkImage,
    required this.isIconButton,
    required this.borderRadius,
    required this.fontSize,
    required this.fontWeight,
    required this.isLightIcon,
    required this.isImageButton,
    required this.addValue,
  }) {
    this.darkImage = darkImage;
  }

  Color backgroundColor;
  String text;
  Icon icon;
  late Image? lightImage;
  late Image? darkImage;
  double borderRadius;
  int fontSize;
  FontWeight fontWeight;

  bool isLightIcon;
  bool isIconButton;
  bool isImageButton;

  ValueChanged<String> addValue;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        addValue(text);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: isLightIcon ? Colors.black : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        textStyle: const TextStyle(
          fontSize: 32,
          fontFamily: 'WorkSans',
          fontWeight: FontWeight.bold,
        ),
      ),
      child: isIconButton
          ? isImageButton
              ? isLightIcon
                  ? lightImage
                  : darkImage
              : icon
          : Text(text),
    );
  }
}
