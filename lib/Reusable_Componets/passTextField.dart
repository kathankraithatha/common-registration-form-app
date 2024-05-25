import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextPassField extends StatelessWidget {
  const CustomTextPassField(this.textIcon, this.textHintText, this.textFieldController, {super.key});
  final TextEditingController textFieldController;
  final String textHintText;
  final Icon textIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 300,
      child: TextField(
        obscureText: true,
        controller: textFieldController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25), // More circular edges
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25), // More circular edges
            borderSide: BorderSide(color: Colors.pinkAccent, width: 2),
          ),
          hintText: textHintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25), // More circular edges
          ),
          suffixIcon: textIcon,

        ),
      ),
    );
  }
}
