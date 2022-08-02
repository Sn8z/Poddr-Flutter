import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    Key? key,
    this.label,
    this.hint,
    this.helper,
    this.prefix,
    this.prefixIcon,
    this.isPassword = false,
    this.autofocus = false,
    this.keyboardType = TextInputType.text,
    required this.textController,
    required this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  final String? label;
  final String? hint;
  final String? helper;
  final Widget? prefix;
  final Widget? prefixIcon;
  final bool isPassword;
  final bool autofocus;
  final TextInputType keyboardType;
  final TextEditingController textController;
  final Function(String) onChanged;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: isPassword,
      onChanged: onChanged,
      autofocus: autofocus,
      onFieldSubmitted: onSubmitted,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).dialogBackgroundColor,
        labelText: label,
        hintText: hint,
        helperText: helper,
        prefix: prefix,
        prefixIcon: prefixIcon,
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
          borderRadius: BorderRadius.circular(16.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 5.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}
