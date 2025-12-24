import 'package:flutter/material.dart';
import 'package:delivery_app/constants/AppColors.dart';

class QuantityButton extends StatelessWidget {
  final IconData icon;
  final bool isEnabled;
  final VoidCallback onTap;
  final Color? color; // لون مخصص عند التوهج أو الوضع العادي

  const QuantityButton({
    Key? key,
    required this.icon,
    required this.isEnabled,
    required this.onTap,
    this.color, // لون مخصص للزر
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(4.0), // إضافة مساحة حول الأيقونة
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isEnabled
              ? (color ?? yellow) // استخدم اللون المخصص أو اللون الافتراضي
              : grey.withOpacity(0.3),
        ),
        child: Icon(icon, color: isEnabled ? Colors.white : grey, size: 24.0),
      ),
    );
  }
}
