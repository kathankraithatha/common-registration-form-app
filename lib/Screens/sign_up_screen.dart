// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_application/Reusable_Componets/buttons.dart';
import 'package:form_application/Reusable_Componets/passTextField.dart';
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
TextEditingController passCheckController=TextEditingController();
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
        title: Text("SignUp Page", style: GoogleFonts.bricolageGrotesque(
            color: Colors.white
        ),),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey.shade100,
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 200,
                    child: Container(child: Lottie.asset('lib/animation/authentication.json'))),
                CustomTextField(Icon(Icons.email), "Enter your email", emailController),
                CustomTextPassField(Icon(Icons.password), "Enter your password", passController),
                CustomTextPassField(Icon(Icons.password), "Confirm your password", passCheckController),
                VerificationButton((){
                  if(passController.text==passCheckController.text){
                    SignUp(emailController.text.toString(), passController.text.toString());
                  } else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Confirm Your Password Again"),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.blue,
                        showCloseIcon: true,
                      ),
                    );
                  }
                }, "Sign Up")

              ],
            ),
          ),
        ),
      ),
    );
  }
}
