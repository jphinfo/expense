import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final String label;

  const AdaptativeTextField({
    required this.controller,
    required this.textInputAction,
    this.keyboardType = TextInputType.text,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: CupertinoTextField(
              controller: controller,
              textInputAction: textInputAction,
              keyboardType: keyboardType,
              placeholder: label,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            ),
          )
        : TextField(
            controller: controller,
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            //onSubmitted: (value) => _subimitForm(), => Inseri a despesa após confirmar o valor
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }
}
