import 'package:flutter/material.dart';

class TextFormInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPass;
  final VoidCallback? callback;
  final String hintText;
  final IconData? iconData;
  final TextInputType textInputType;

  const TextFormInputField(
      {Key? key,
      required this.controller,
      this.isPass = false,
      this.iconData,
      this.callback,
      required this.hintText,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      decoration: InputDecoration(
        suffixIcon: IconButton(onPressed: callback, icon: Icon(iconData)),
        fillColor: Colors.white,
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      controller: controller,
      obscureText: isPass,
    );
  }
}
