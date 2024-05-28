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
<<<<<<< HEAD
    TextEditingController(), // Designation controller
    TextEditingController(), // age controller
=======
    TextEditingController(), // mobile number controller
    TextEditingController(), // mobile number controller
>>>>>>> f88da5ccc2e4e501b161a6e0a28bf9ea481f0bc8
  ];
  final UserDatabaseMethods userDatabaseMethods = UserDatabaseMethods();

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
                    shrinkWrap: true,
                    // Wrap the content to avoid unnecessary space
                    physics: NeverScrollableScrollPhysics(),
                    // Disable scrolling if only a few fields
                    itemCount: controllers.length,
                    // Use the length of controllers list
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FormTextfield(
                          getInputType(index),
                          getIcon(index),
                          // Get the appropriate icon based on index
                          getLabelText(index),
                          // Get the appropriate label text based on index
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
                  bool emailExists =
                      await userDatabaseMethods.checkEmailExists(email);
                  bool isAnyFieldEmpty = false;
                  for (var controller in controllers) {
                    if (controller.text.isEmpty) {
                      isAnyFieldEmpty = true;
                      break;
                    }
                  }
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
                        content: Text(
                            "Email already in use. Please use a different email."),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                        showCloseIcon: true,
                      ),
                    );
                  } else {
                    String Id = randomAlpha(10); // Use Random Library
                    Map<String, dynamic> userDetails = {
                      "Name": controllers[0].text,
                      "Email": controllers[1].text,
                      "PhoneNo": controllers[2].text,
                      "Designation": controllers[3].text,
                      "Age": controllers[4].text,
                    };
                    await userDatabaseMethods
                        .addUserBasicDetails(userDetails, Id)
                        .then((value) async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
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
                              builder: (context) => const DashboardScreen()));
                    });
                  }
                  controllers.forEach((controller) => controller.clear());
                }, "Submit Basic Details"),
              ),
              Center(
                child: Text(
                  "OR",
                  style: GoogleFonts.josefinSans(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
              Center(
                child: VerificationButton(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DashboardScreen()));
                }, "Already Filled?"),
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
