import 'package:flutter/material.dart';

class CustomTextFaild extends StatelessWidget {
  final String TextHint;
  final TextEditingController myController;
  final String? Function(String?)? validator;

  const CustomTextFaild({super.key, required this.TextHint, required this.myController, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: myController,
      decoration: InputDecoration(
        hintText: TextHint,
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 206, 206, 206),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 210, 210, 210),
          ),
        ),
      ),
    );
  }
}
