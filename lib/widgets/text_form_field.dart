import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    required this.validator,
    required this.hint,
    required this.controller,
    required this.isObscure,
  }) : super(key: key);
  final String? Function(String?) validator;
  final String hint;
  final TextEditingController controller;
  final bool isObscure;

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obsecureClicked = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isObscure & !obsecureClicked,
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        errorMaxLines: 2,
        suffixIcon: widget.isObscure
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: IconButton(
                  icon: Icon(
                    !obsecureClicked
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        obsecureClicked = !obsecureClicked;
                      },
                    );
                  },
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(
            color: kPrimaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hint,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 15.0,
        ),
        hintStyle: const TextStyle(
          color: Colors.black38,
        ),
      ),
    );
  }
}
