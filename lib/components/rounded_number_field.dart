import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

import '../constants.dart';
import 'textField_container.dart';

class RoundedNumberInputField extends StatefulWidget {
  final String? hintText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? numController;
  const RoundedNumberInputField({
    Key? key,
    this.hintText,
    this.icon = Icons.phone,
    this.onChanged,
    this.numController,
  }) : super(key: key);

  @override
  State<RoundedNumberInputField> createState() =>
      _RoundedNumberInputFieldState();
}

class _RoundedNumberInputFieldState extends State<RoundedNumberInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: widget.numController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your phone number';
          } else if (isAlpha(value)) {
            return 'Only Numbers Please';
          } else if (value.length != 10) {
            return 'Please enter a VALID phone number';
          }
          return null;
        },
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            prefixIcon: Text(
              "+7-",
              style: TextStyle(fontSize: 17),
            ),
            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
            hintText: widget.hintText,
            icon: Icon(
              widget.icon,
              color: kPrimaryColor,
            ),
            border: InputBorder.none),
        keyboardType: TextInputType.phone,
      ),
    );
  }
}
