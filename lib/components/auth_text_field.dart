import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {

  final String hintText;
  final TextEditingController controller;

  const AuthTextField({super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: hintText == "Enter password",
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: hintText
      ),
      onTapOutside: (event){
        FocusManager.instance.primaryFocus?.unfocus();
      }
    );
  }
}
