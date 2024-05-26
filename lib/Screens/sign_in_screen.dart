import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_application/Reusable_Componets/buttons.dart';
import 'package:form_application/Reusable_Componets/passTextField.dart';
import 'package:form_application/Reusable_Componets/textfield.dart';
import 'package:form_application/Screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isLoading=false;

  bool isValidEmail(String email) {
    RegExp regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  SignIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter Credentials"),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.blue,
          showCloseIcon: true,
        ),
      );
    } else if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email is badly formatted"),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          showCloseIcon: true,
        ),
      );
    } else {
      setState(() {
        isLoading=true;
      });
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        setState(() {
          isLoading=false;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
        setState(() {
          isLoading=false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
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
        title: Text(
          "SignIn Page",
          style: GoogleFonts.roboto(color: Colors.white),
        ),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      body: Stack(
        children:[ Container(

          height: double.infinity,
          width: double.infinity,
          color: Colors.grey.shade100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: Container(child: Lottie.asset('lib/animation/authentication.json')),
              ),
              CustomTextField(Icon(Icons.email), "Enter Your Email", emailController),
              CustomTextPassField(Icon(Icons.password), "Enter Your Password", passController),
              VerificationButton(() {
                const SnackBar(
                  content: Text("An unexpected error occurred."),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.pinkAccent,
                  showCloseIcon: true,
                  animation: AlwaysStoppedAnimation(double.infinity),
                );

                SignIn(emailController.text.toString(), passController.text.toString());

              }, "Sign In")
            ],
          ),
        ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(), // Show loading indicator
            ),
      ]
      ),
    );
  }
}
