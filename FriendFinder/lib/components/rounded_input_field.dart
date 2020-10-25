import 'package:flutter/material.dart';
import 'package:friendfinder/components/text_field_container.dart';
import 'package:friendfinder/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        style: TextStyle(color: Colors.black),
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
