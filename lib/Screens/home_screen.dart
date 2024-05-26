import 'package:flutter/material.dart';
import 'package:form_application/Screens/intro_screen.dart';
import 'package:google_fonts/google_fonts.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const IntroScreen()));
          },
            child: Icon(Icons.logout,color: Colors.white)
        ),
        title: Text("Home Screen", style: GoogleFonts.roboto(
            color: Colors.white
        ),),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      body: const Center(child: Text("hello")),
    );
  }
}
