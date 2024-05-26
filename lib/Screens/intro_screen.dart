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
        leading: Icon(Icons.home, color: Colors.white,),
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
              Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => SignUpScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child){
                    const begin = Offset(2.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.decelerate;
                    var tween = Tween(begin: begin, end: end).chain(
                        CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  }
                )
              );
            }, "SignUp"),

            VerificationButton((){
              Navigator.push(context,
              PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation)=> SignInScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(2.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.decelerate;
                  var tween=Tween(begin: begin, end: end).chain(
                    CurveTween(curve: curve)
                  );
                  return SlideTransition(position: animation.drive(tween), child: child);
                }
              )
              );
            },"SignIn"),
          ],
        ),
      ),
    );
  }
}
