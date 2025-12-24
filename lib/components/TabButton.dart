import 'package:flutter/material.dart';
import 'package:delivery_app/constants/AppColors.dart';

// كلاس لإنشاء الأزرار
class TabButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const TabButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: isSelected ? yellow : Colors.transparent,
          borderRadius: BorderRadius.circular(30.0), // Rounded corners
          border: Border.all(color: yellow),
          boxShadow: [
            BoxShadow(
              color: isSelected ? yellow.withOpacity(0.5) : Colors.transparent,
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? offWhite : yellow),
            const SizedBox(width: 8.0),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? offWhite : yellow,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
