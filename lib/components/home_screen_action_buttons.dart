import 'package:flutter/material.dart';
import 'package:untitled/utils/colours.dart';


class HomeScreenActionButtons extends StatelessWidget {
  final String text;
  final IconData icon;
 final VoidCallback onPressed;
  const HomeScreenActionButtons({super.key, required this.onPressed, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadiusGeometry.circular(16),
              boxShadow:  [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.06),
                  offset:  Offset(0, 4)
                )
              ]
            ),
            child: Icon(icon),
          ),
          SizedBox(height: 10,),
          Text(text, style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w600
          ),)
        ],
      ),
    );
  }
}
