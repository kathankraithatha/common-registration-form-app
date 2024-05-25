// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_application/Reusable_Componets/buttons.dart';
import 'package:form_application/Reusable_Componets/textfield.dart';
import 'package:form_application/Screens/home_screen.dart';
import 'package:form_application/Screens/sign_in_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lottie/lottie.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

TextEditingController emailController=TextEditingController();
TextEditingController passController=TextEditingController();
SignUp(String email, String password) async {
  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Enter Credentials"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blue,
        showCloseIcon: true,
      ),
    );
  } else {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
    } on FirebaseAuthException catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error occurred: ${ex.message}"),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          showCloseIcon: true,
        ),
      );
      print("FirebaseAuthException: ${ex.code} - ${ex.message}");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An unexpected error occurred."),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          showCloseIcon: true,
        ),
      );
      print("Exception: ${e.toString()}");
    }
  }
}


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
            CustomTextField(Icon(Icons.email), "Enter your email", emailController),
            CustomTextField(Icon(Icons.password), "Enter your password", passController),
            VerificationButton((){
              SignUp(emailController.text.toString(), passController.text.toString());
            }, "Submit")

          ],
        ),
      ),
    );
  }
}
