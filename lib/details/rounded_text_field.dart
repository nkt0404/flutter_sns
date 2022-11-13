import 'package:flutter/material.dart';
import 'package:flutter_sns/details/text_field_container.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({
    Key? key,
    required this.keybordType,
    required this.onChanged,
    required this.controller,
    required this.shadowColor,
    required this.borderColor,
    required this.hintText,
  }) : super(key: key);
  final TextInputType keybordType;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final Color borderColor;
  final Color shadowColor;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      shadowColor: shadowColor,
      borderColor: borderColor,
      child: TextFormField(
        keyboardType: keybordType,
        onChanged: onChanged,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(fontWeight: FontWeight.bold)),
        controller: controller,
      ),
    );
  }
}
