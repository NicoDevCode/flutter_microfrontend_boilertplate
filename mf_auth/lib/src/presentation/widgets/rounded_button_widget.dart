import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final double fontSize;
  final EdgeInsets margin;

  const RoundedButtonWidget({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    required this.textColor,
    required this.onPressed,
    this.height = 50.0,
    this.width = double.infinity,
    this.fontSize = 16.0,
    this.margin = const EdgeInsets.symmetric(vertical: 16.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
} 