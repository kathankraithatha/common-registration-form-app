import 'package:flutter/material.dart';
class VerificationButton extends StatelessWidget {
   const VerificationButton(this.onTap, this.buttonText,{super.key});
   final String buttonText;
   final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: OutlinedButton(
        onPressed:onTap,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(Colors.pinkAccent.shade200),
        ),
        child: Text(buttonText, style: const TextStyle(color: Colors.white),),
      ),
    );
  }
}
