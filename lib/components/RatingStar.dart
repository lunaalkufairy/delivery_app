import 'package:flutter/material.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/constants/UiHelper.dart';

class RatingStars extends StatelessWidget {
  final int rating; // التقييم الحالي
  final int totalStars; // عدد النجوم الكلي
  final ValueChanged<int> onRate; // استدعاء عند التقييم

  const RatingStars({
    required this.rating,
    required this.totalStars,
    required this.onRate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalStars, (index) {
        return GestureDetector(
          onTap: () {
            if (index == rating - 1) {
              // إذا تم الضغط على نفس النجمة المفعّلة، قم بإلغاء التقييم
              onRate(0);
            } else {
              // تحديد التقييم بناءً على النجمة المضغوط عليها
              onRate(index + 1);
            }
          },
          child: Icon(
            stars,
            color: index < rating ? yellow : grey, // شرط اللون
            size: 30,
            shadows: [
              if (index < rating) // تفعيل الإضاءة فقط إذا كانت النجمة مفعّلة
                Shadow(
                  color: yellow.withOpacity(0.9),
                  blurRadius: 20, // مدى تشويش الإضاءة
                ),
            ],
          ),
        );
      }),
    );
  }
}
