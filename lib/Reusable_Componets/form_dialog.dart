import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../database/adding_data.dart';
import '../database/admin_database_methods.dart';

class FormDialog extends StatefulWidget {
  final String formId;
  final String userEmail;

  FormDialog({required this.formId, required this.userEmail});

  @override
  _FormDialogState createState() => _FormDialogState();
}

class _FormDialogState extends State<FormDialog> {
  final AdminDatabaseMethods adminDatabaseMethods = AdminDatabaseMethods();
  final UserDatabaseMethods userDatabaseMethods = UserDatabaseMethods();
  final List<TextEditingController> controllers = [];
  List<String> fields = [];

  @override
  void initState() {
    super.initState();
    _loadFormFields();
  }

  Future<void> _loadFormFields() async {
    final formData = await adminDatabaseMethods.getFormFields(widget.formId);
    if (formData != null && formData.containsKey('fields')) {
      setState(() {
        fields = List<String>.from(formData['fields']);
        controllers.addAll(fields.map((field) => TextEditingController()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Form Details',
        style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: fields.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Form(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(fields.length, (index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: controllers[index],
                  decoration: InputDecoration(
                    hintText: fields[index], // Set the hint to the value from fields
                  ),
                ),
              );
            }),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: GoogleFonts.roboto(color: Colors.red)),
        ),
        ElevatedButton(
          onPressed: () async {
            Map<String, dynamic> formSubmissionData = {};
            for (int i = 0; i < fields.length; i++) {
              formSubmissionData[fields[i]] = controllers[i].text;
            }

            final userBasicDetails = await userDatabaseMethods.getUserDataByEmail(widget.userEmail);

            if (userBasicDetails != null) {
              await adminDatabaseMethods.addUserFormSubmission(
                widget.userEmail,
                widget.formId,
                formSubmissionData,
                userBasicDetails,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Form Submitted Successfully"),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.blue,
                  showCloseIcon: true,
                ),
              );

              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Error: User basic details not found"),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  showCloseIcon: true,
                ),
              );
            }
          },
          child: Text('Save', style: GoogleFonts.roboto()),
        ),
      ],
    );
  }
}
