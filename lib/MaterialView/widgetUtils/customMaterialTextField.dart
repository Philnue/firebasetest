import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomMaterialTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const CustomMaterialTextField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      autocorrect: false,

      //enabled: Format.isAcceptTime,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: '$hintText',
      ),
    );
  }
}
