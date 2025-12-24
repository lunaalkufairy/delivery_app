import 'package:flutter/material.dart';
import 'package:delivery_app/constants/AppColors.dart';

class CustomNameTextField extends StatefulWidget {
  final TextEditingController controller;
  final String fieldName;
  final TextStyle? style;
  final Icon? icon;

  const CustomNameTextField({
    Key? key,
    required this.controller,
    required this.fieldName,
    this.style,
    this.icon,
  }) : super(key: key);

  @override
  _CustomNameTextFieldState createState() => _CustomNameTextFieldState();
}

class _CustomNameTextFieldState extends State<CustomNameTextField> {
  late FocusNode _focusNode;
  bool _isEmpty = false;
  bool _wasFocused = false; // لمعرفة ما إذا كان المستخدم قد ضغط على الحقل

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        // تحديث حالة النص عند فقدان التركيز
        if (!_focusNode.hasFocus && _wasFocused) {
          _isEmpty = widget.controller.text.isEmpty;
        }
        if (_focusNode.hasFocus) {
          _wasFocused = true; // سجل أن الحقل تم النقر عليه مرة واحدة على الأقل
        }
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      cursorColor: yellow,
      onChanged: (value) {
        setState(() {
          _isEmpty = value.isEmpty;
        });
      },
      decoration: InputDecoration(
        labelText: widget.fieldName,
        labelStyle: TextStyle(color: greydark, fontSize: 15),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: TextStyle(
          fontSize: 20,
          color: _isEmpty ? red : yellow,
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: _isEmpty ? red : yellow, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: _isEmpty && _wasFocused ? red : greydark,
            width: 2.0,
          ),
        ),
        suffixIcon: widget.icon,
      ),
      style: widget.style ?? TextStyle(fontFamily: 'Sofia', fontSize: 16),
    );
  }
}
