import 'package:flutter/material.dart';

class StaticIconButton extends StatefulWidget {
  final IconData icon; // الأيقونة
  final String iconName; // اسم الأيقونة
  final Color color; // لون الأيقونة
  final VoidCallback onTap; // الإجراء عند النقر

  const StaticIconButton({
    required this.icon,
    required this.iconName,
    required this.color,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _StaticIconButtonState createState() => _StaticIconButtonState();
}

class _StaticIconButtonState extends State<StaticIconButton> {
  bool _isGlowing = false; // للتحكم بالإضاءة عند النقر

  void _handleTap() {
    setState(() {
      _isGlowing = true; // تشغيل الإضاءة عند النقر
    });

    // إعادة الإضاءة للحالة العادية بعد وقت معين
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _isGlowing = false; // إطفاء الإضاءة
      });
    });

    widget.onTap(); // استدعاء الإجراء عند النقر
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: widget.color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30.0), // شكل مستطيل مستدير
          boxShadow: _isGlowing
              ? [
                  BoxShadow(
                    color: widget.color.withOpacity(0.5), // لون الإضاءة
                    blurRadius: 20, // مدى تشويش الإضاءة
                    spreadRadius: 5, // مدى انتشار الإضاءة
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              color: widget.color,
              size: 25.0,
            ),
            const SizedBox(width: 2.0), // مسافة بين الأيقونة والنص
            Text(
              widget.iconName,
              style: TextStyle(
                color: widget.color,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
