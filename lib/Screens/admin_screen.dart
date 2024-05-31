import 'package:flutter/material.dart';
import 'package:form_application/Reusable_Componets/buttons.dart';
import 'package:form_application/Reusable_Componets/form_textfield.dart';
import 'package:form_application/database/admin_database_methods.dart';
import 'package:form_application/screens/dashboard_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_string/random_string.dart';

import 'admin_dashboard_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController fieldController = TextEditingController();
  final AdminDatabaseMethods adminDatabaseMethods = AdminDatabaseMethods();
  List<String> fieldHints = [];
  bool isSubmitting = false;

  Future<void> generateForm() async {
    if (titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Title cannot be empty")),
      );
      return;
    }

    if (fieldHints.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("At least one field must be added")),
      );
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    // Generate a unique ID for the form
    String id = randomAlpha(10);

    // Create a form information map
    Map<String, dynamic> formFieldInfo = {
      "title": titleController.text,
      "fields": fieldHints,
    };

    // Save the form to the database
    await adminDatabaseMethods.addFormField(formFieldInfo, id);

    setState(() {
      isSubmitting = false;
      titleController.clear();
      fieldHints.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Form generated successfully")),
    );
  }

  void addField() {
    if (fieldController.text.isNotEmpty) {
      setState(() {
        fieldHints.add(fieldController.text);
        fieldController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Field hint cannot be empty")),
      );
    }
  }

  void removeRecentField() {
    if (fieldHints.isNotEmpty) {
      setState(() {
        fieldHints.removeLast();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No fields to remove")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin Screen",
          style: GoogleFonts.roboto(color: Colors.white),
        ),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Generate Form:",
                    style: GoogleFonts.roboto(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  SizedBox(height: 8),
                  FormTextfield(
                    TextInputType.name,
                    Icon(Icons.title),
                    "Enter Title",
                    titleController,
                  ),
                  SizedBox(height: 6),
                  ...fieldHints.map((hint) => FormTextfield(
                    TextInputType.text,
                    Icon(Icons.text_fields),
                    hint,
                    TextEditingController(),
                  )),
                  SizedBox(height: 10),
                  Center(
                    child: VerificationButton(() {
                      removeRecentField();
                    }, "Remove recent field"),
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: isSubmitting
                        ? CircularProgressIndicator()
                        : VerificationButton(() async {
                      await generateForm();
                    }, "Generate Form"),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: VerificationButton(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminDashboardScreen()),
                      );
                    }, "Go to dashboard"),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(bottom: 26.0, right: 20),
              child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        'Add Field:',
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FormTextfield(
                            TextInputType.text,
                            Icon(Icons.text_fields),
                            "Enter field hint",
                            fieldController,
                          ),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              addField();
                              Navigator.of(context).pop();
                            },
                            child: Text("Save Field"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
