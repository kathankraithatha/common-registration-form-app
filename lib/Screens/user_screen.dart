// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:form_application/Reusable_Componets/form_textfield.dart';
import 'package:form_application/Reusable_Componets/textfield.dart';
import 'package:google_fonts/google_fonts.dart';

class UserScreen extends StatelessWidget {
  UserScreen({super.key});
  final List<TextEditingController> controllers = [
    TextEditingController(), // Name controller
    TextEditingController(), // Email controller
    TextEditingController(), // mobile number controller
    TextEditingController(), // mobile number controller
    TextEditingController(), // mobile number controller
    // Add more controllers as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Screen", style: GoogleFonts.roboto(
            color: Colors.white
        ),),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                child: Text(
                  "Enter Basic Details:",
                  style: GoogleFonts.rem(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: ListView.builder(
                    shrinkWrap: true, // Wrap the content to avoid unnecessary space
                    physics: NeverScrollableScrollPhysics(), // Disable scrolling if only a few fields
                    itemCount: controllers.length, // Use the length of controllers list
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FormTextfield(
                          getInputType(index),
                          getIcon(index), // Get the appropriate icon based on index
                          getLabelText(index), // Get the appropriate label text based on index
                          controllers[index],
          
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Helper methods to provide icons and labels based on index (optional):
  Icon getIcon(int index) {
    switch (index) {
      case 0:
        return Icon(Icons.person);
      case 1:
        return Icon(Icons.email);
        case 2:
        return Icon(Icons.phone);
        case 3:
        return Icon(Icons.work);
        case 4:
        return Icon(Icons.person_add_alt_rounded);
      default:
        return Icon(Icons.info); // Default icon
    }
  }

  String getLabelText(int index) {
    switch (index) {
      case 0:
        return "Enter your full name";
      case 1:
        return "Enter your email address";
        case 2:
        return "Enter your phone number";
        case 3:
        return "Enter your designation";
        case 4:
        return "Enter your age";
      default:
        return "Enter additional details"; // Default label
    }
  }
  TextInputType getInputType(int index) {
    switch (index) {
      case 0:
        return TextInputType.text; // Name
      case 1:
        return TextInputType.emailAddress; // Email
      case 2:
        return TextInputType.phone; // Phone number
      case 3:
        return TextInputType.text; // Designation
      case 4:
        return TextInputType.number; // Age
      default:
        return TextInputType.text;
    }
  }

}
