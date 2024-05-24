// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:form_application/Reusable_Componets/buttons.dart';
import 'package:form_application/Screens/sign_in_screen.dart';
import 'package:form_application/Screens/sign_up_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          children:  [
            SizedBox(width: 200,
                child: Container(child: Lottie.asset('lib/animation/form2.json'))),
            VerificationButton((){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
            }, "SignUp"),

            VerificationButton((){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
            },"SignIn"),
          ],
        ),
      ),
    );
  }
}
