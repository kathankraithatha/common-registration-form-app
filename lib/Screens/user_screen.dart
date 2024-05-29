import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_application/Reusable_Componets/buttons.dart';
import 'package:form_application/Reusable_Componets/form_textfield.dart';
import 'package:form_application/database/adding_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard_screen.dart';

class BasicDetailsScreen extends StatelessWidget {
  BasicDetailsScreen({super.key});

  final List<TextEditingController> controllers = [
    TextEditingController(), // Name controller
    TextEditingController(), // Email controller
    TextEditingController(), // mobile number controller
    TextEditingController(), // Designation controller
    TextEditingController(), // age controller
  ];
  final UserDatabaseMethods userDatabaseMethods = UserDatabaseMethods();
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Screen",
          style: GoogleFonts.roboto(color: Colors.white),
        ),
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
                  style: GoogleFonts.roboto(
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
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controllers.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FormTextfield(
                          getInputType(index),
                          getIcon(index),
                          getLabelText(index),
                          controllers[index],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Center(
                child: VerificationButton(() async {
                  String email = controllers[1].text;
                  bool emailExists = await userDatabaseMethods.checkEmailExists();
                  bool isAnyFieldEmpty = controllers.any((controller) => controller.text.isEmpty);

                  if (isAnyFieldEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Enter Data"),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                        showCloseIcon: true,
                      ),
                    );
                  } else if (emailExists) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Email already in use. Please use a different email."),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                        showCloseIcon: true,
                      ),
                    );
                  } else {
                    String id = randomAlpha(10);
                    Map<String, dynamic> userDetails = {
                      "Name": controllers[0].text,
                      "Email": controllers[1].text,
                      "PhoneNo": controllers[2].text,
                      "Designation": controllers[3].text,
                      "Age": controllers[4].text,
                    };

                    await userDatabaseMethods.addUserBasicDetails(userDetails, id).then((value) async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setString('loggedInUserEmail', email);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Data Entered Successfully"),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.blue,
                          showCloseIcon: true,
                        ),
                      );
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashboardScreen(email: email)));
                    });
                  }
                  controllers.forEach((controller) => controller.clear());
                }, "Submit Basic Details"),
              ),
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
        return const Icon(Icons.person);
      case 1:
        return const Icon(Icons.email);
      case 2:
        return const Icon(Icons.phone);
      case 3:
        return const Icon(Icons.work);
      case 4:
        return const Icon(Icons.person_add_alt_rounded);
      default:
        return const Icon(Icons.info);
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
        return "Enter additional details";
    }
  }

  TextInputType getInputType(int index) {
    switch (index) {
      case 0:
        return TextInputType.text;
      case 1:
        return TextInputType.emailAddress;
      case 2:
        return TextInputType.phone;
      case 3:
        return TextInputType.text;
      case 4:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }
}
