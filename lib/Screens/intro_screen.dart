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
        title: Text("Evently", style: GoogleFonts.bricolageGrotesque(
          color: Colors.white,
              fontWeight: FontWeight.bold
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
            Text(
              "Evently",
              style: GoogleFonts.kalam(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent.shade700,
              ),
            ),
            SizedBox(height: 8,),
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
            SizedBox(height: 20,),
            Text(
              "Evently Your Exclusive Form Filling Destination ✨",
              style: GoogleFonts.kalam(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent.shade700,
                fontStyle: FontStyle.italic
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
