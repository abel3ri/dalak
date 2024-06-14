import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FormInputField extends StatelessWidget {
  String labelText;
  String hintText;
  IconData prefixIcon;
  bool obscureText;
  TextInputType keyBoardType;
  TextInputAction textInputAction;
  TextEditingController controller;
  IconData sufficIcon;
  void Function()? onSuffixIconTap;
  String? Function(String? value)? validator;
  FormInputField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.keyBoardType,
    required this.textInputAction,
    required this.validator,
    this.sufficIcon = Icons.visibility_off,
    this.obscureText = false,
    this.onSuffixIconTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyBoardType,
          obscureText: obscureText,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            suffixIcon: labelText == 'Password'
                ? IconButton(
                    onPressed: onSuffixIconTap,
                    icon: Icon(sufficIcon),
                  )
                : null,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 16),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
