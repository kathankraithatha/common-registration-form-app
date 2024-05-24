import 'package:flutter/material.dart';
class VerificationButton extends StatelessWidget {
   VerificationButton(this.buttonText,{super.key});
   String buttonText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: OutlinedButton(
        onPressed: () {

        },
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(Colors.pinkAccent.shade200),
        ),
        child: Text(buttonText, style: const TextStyle(color: Colors.white),),
      ),
    );
  }
}
