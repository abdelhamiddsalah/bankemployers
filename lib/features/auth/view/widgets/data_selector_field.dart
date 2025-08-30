import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class DateSelectorField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isForBirth;

  const DateSelectorField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.isForBirth = true,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = isForBirth 
        ? now.subtract(Duration(days: 6570)) // 18 years ago
        : now;
    
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1950),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: maincolor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      controller.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: CustomTextField(
          hintText: hintText,
          iconData: Icons.calendar_today_outlined,
          controller: controller,
          validator: validator,
        ),
      ),
    );
  }
}