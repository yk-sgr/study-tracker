import 'package:flutter/material.dart';
import 'package:study_tracker/theme/app_theme.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  TextInput({required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyText1,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.darkTextColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.darkTextColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
      ),
      style: Theme.of(context).textTheme.bodyText1,
      textAlign: TextAlign.center,
    );
  }
}