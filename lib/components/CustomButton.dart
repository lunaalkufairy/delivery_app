import 'package:flutter/material.dart';
import 'package:delivery_app/constants/AppColors.dart';

class CustomButton extends StatelessWidget {
  final String textOfButton;
  final VoidCallback onPressed;

  const CustomButton({required this.textOfButton, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: yellow, // لون الزر
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // زوايا دائرية
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 13.0,
        ), // تباعد داخلي
        elevation: 20, // الظل
      ),
      child: Text(
        textOfButton,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: offWhite,
        ),
      ),
    );
  }
}
