import 'package:flutter/material.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/logic/DatePickerLogic.dart';

class CustomDatePickerField extends StatefulWidget {
  final TextEditingController controller;
  final String fieldName;
  final DatePickerLogic datePickerLogic;

  const CustomDatePickerField({
    Key? key,
    required this.controller,
    required this.fieldName,
    required this.datePickerLogic,
  }) : super(key: key);

  @override
  _CustomDatePickerFieldState createState() =>
      _CustomDatePickerFieldState(fieldName: fieldName);
}

class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
  final String fieldName;
  _CustomDatePickerFieldState({required this.fieldName});
  bool _showError = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    // Monitor loss of focus and check text
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          // trim() Removes extra spaces at the beginning and end
          _showError = widget.controller.text.trim().isEmpty;
        });
      }
    });
  }

  // @override
  // void dispose() {
  //   _focusNode.dispose();
  //   super.dispose();
  // }

  // to open widget date selection
  void _handleDateSelection() async {
    FocusScope.of(context).requestFocus(_focusNode); // Set focus on the field
    String? selectedDate = await widget.datePickerLogic.selectDate(context);
    if (selectedDate != null) {
      setState(() {
        widget.controller.text = selectedDate;
        _showError = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleDateSelection,
      behavior: HitTestBehavior
          .opaque, // Make the pressure area include the entire field
      child: AbsorbPointer(
        child: TextField(
          cursorColor: yellow,
          controller: widget.controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            labelText: fieldName != null ? fieldName : 'Date',
            labelStyle: TextStyle(color: greydark, fontSize: 16),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            floatingLabelStyle: TextStyle(fontSize: 20, color: yellow),

            hintText: widget.fieldName,
            hintStyle: TextStyle(color: greydark),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            // in focus mood
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: yellow, width: 2.0),
            ),
            // unfoucs mood
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: greydark, width: 2.0),
            ),
            suffixIcon: Icon(Icons.calendar_today, color: greydark),
          ),
          style: const TextStyle(fontFamily: 'Sofia', fontSize: 16),
        ),
      ),
    );
  }
}
