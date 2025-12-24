import 'package:flutter/material.dart';

class AnimatedIconButton extends StatefulWidget {
  final IconData icon; // الأيقونة
  final String iconName; // اسم الأيقونة
  final Color glowColor; // لون الإضاءة
  final VoidCallback onTap; // الإجراء عند النقر
  final bool shouldAnimate; // التحكم في الحركة

  const AnimatedIconButton({
    required this.icon,
    required this.iconName,
    required this.glowColor,
    required this.onTap,
    required this.shouldAnimate,
    Key? key,
  }) : super(key: key);

  @override
  _AnimatedIconButtonState createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false; // للتحكم بالإضاءة عند مرور الماوس
  bool _isGlowing = false; // للتحكم بالإضاءة عند النقر

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant AnimatedIconButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldAnimate) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true; // تفعيل الإضاءة عند مرور الماوس
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false; // إطفاء الإضاءة عند خروج الماوس
        });
      },
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isGlowing = true; // تشغيل الإضاءة عند النقر
          });

          // إطفاء الإضاءة بعد فترة قصيرة
          Future.delayed(const Duration(milliseconds: 300), () {
            setState(() {
              _isGlowing = false;
            });
          });

          widget.onTap(); // استدعاء الإجراء عند النقر
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: (_isHovered || _isGlowing || widget.shouldAnimate)
                  ? _scaleAnimation.value
                  : 1.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: widget.glowColor.withOpacity(0.2), // خلفية شفافة
                  borderRadius: BorderRadius.circular(30.0), // زر مستطيل مستدير
                  boxShadow: (_isHovered || _isGlowing || widget.shouldAnimate)
                      ? [
                          BoxShadow(
                            color: widget.glowColor.withOpacity(0.4),
                            spreadRadius: 5, // انتشار الإضاءة
                            blurRadius: 10, // نعومة الإضاءة
                          ),
                        ]
                      : [],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.icon,
                      color: widget.glowColor,
                      size: 29.0,
                    ),
                    const SizedBox(width: 8.0), // مسافة بين الأيقونة والنص
                    Text(
                      widget.iconName,
                      style: TextStyle(
                        color: widget.glowColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
