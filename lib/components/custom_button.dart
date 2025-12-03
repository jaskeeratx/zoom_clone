import 'package:flutter/material.dart';
import 'package:untitled/utils/colours.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(30),
            side: const BorderSide(color: buttonColor)
          )
        ),
        child: Text(buttonText, style: TextStyle(fontSize: 17,color: Colors.white)),

      ),
    );
  }
}
