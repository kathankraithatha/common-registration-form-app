// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Common Registration Form", style: GoogleFonts.roboto(
            color: Colors.white
        ),),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 200,
                child: Container(child: Lottie.asset('lib/animation/authentication.json'))),
          ],
        ),
      ),
    );
  }
}
