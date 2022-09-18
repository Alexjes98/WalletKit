// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class InputTextField extends StatefulWidget {
  const InputTextField(
      {Key? key,
      this.labelText,
      this.icon,
      this.initialValue,
      this.hintText,
      this.errorMessage,
      this.inputController,
      this.keyboardType,
      this.formatters})
      : super(key: key);

  final inputController;
  final keyboardType;
  final formatters;

  final labelText;
  final icon;

  final initialValue;
  final hintText;
  final errorMessage;

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  void setError() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: widget.inputController,
        keyboardType:
            widget.keyboardType ?? const TextInputType.numberWithOptions(),
        inputFormatters: widget.formatters,
        initialValue: widget.initialValue,
        style: const TextStyle(color: primaryVariant),
        cursorColor: primaryVariant,
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: primaryVariant),
          labelText: widget.labelText,
          fillColor: primaryVariant,
          focusColor: white,
          errorText: widget.errorMessage,
          suffixIcon: Icon(
            widget.icon,
            color: primaryVariant,
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: primaryColor),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: primaryVariant)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: errorColor)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor)),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor)),
        ),
      ),
    );
  }
}
