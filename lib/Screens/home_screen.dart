// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_application/Screens/admin_screen.dart';
import 'package:form_application/Screens/intro_screen.dart';
import 'package:form_application/Screens/user_screen.dart';
import 'package:form_application/database/adding_data.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dashboard_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final UserDatabaseMethods userDatabaseMethods = UserDatabaseMethods();

  void checkUserAndNavigate(BuildContext context) async {
    bool userExists = await userDatabaseMethods.checkEmailExists();

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => userExists
            ? UserDashboardScreen(
                email: firebaseAuth.currentUser!.email.toString(),
              )
            : BasicDetailsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(2.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.decelerate;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const IntroScreen()));
            },
            child: Icon(Icons.logout, color: Colors.white)),
        title: Text(
          "Home Screen",
          style: GoogleFonts.bricolageGrotesque(color: Colors.white),
        ),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.grey.shade100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Image(
                image: AssetImage("lib/animation/screen.png"),
                height: 200,
              )),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                  onTap: () {
                    checkUserAndNavigate(context);
                  },
                  child: Text(
                    "Be a user",
                    style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800),
                  )),
              Text(
                "OR",
                style: GoogleFonts.merienda(
                    fontSize: 20,
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                  onTap: () async {
                    if (await userDatabaseMethods.checkEmailExists()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("You are already a user."),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.blue,
                          showCloseIcon: true,
                        ),
                      );
                    } else{
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                  AdminScreen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = Offset(2.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.decelerate;
                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              }));
                    }

                  },
                  child: Text(
                    "Be a form creator",
                    style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800),
                  )),
            ],
          )),
    );
  }
}
