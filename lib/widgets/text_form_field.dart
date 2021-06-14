import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.validator,
    required this.hint,
    required this.controller,
    required this.isObscure,
  }) : super(key: key);
  final validator;
  final hint;
  final controller;
  final isObscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(
            color: KPrimaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        hintStyle: TextStyle(color: Colors.black38),
      ),
    );
  }
}
