import 'package:flutter/material.dart';
class FormTextfield extends StatelessWidget {
  const FormTextfield(this.formInputType,this.textIcon, this.textHintText, this.textFieldController, {super.key});
  final TextEditingController textFieldController;
  final String textHintText;
  final Icon textIcon;
  final TextInputType formInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      child: TextField(
        controller: textFieldController,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25), // More circular edges
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25), // More circular edges
              borderSide: const BorderSide(color: Colors.pinkAccent, width: 2),
            ),
            labelText: textHintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25), // More circular edges
            ),
            suffixIcon: textIcon,
        ),
        keyboardType: formInputType,

      ),
    );
  }
}
