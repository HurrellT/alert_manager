import 'package:flutter/material.dart';

class AlarmTextFormField extends StatelessWidget {
  final String hintText, validatorText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const AlarmTextFormField({
    this.keyboardType = TextInputType
        .text, //This is currently NOT working for Flutter web and desktop
    this.controller,
    this.hintText,
    this.validatorText,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        keyboardType: keyboardType,
        validator: (value) {
          if (value.isEmpty) {
            return validatorText;
          }
          return null;
        },
        decoration: InputDecoration(hintText: hintText),
        controller: controller,
      ),
    );
  }
}
