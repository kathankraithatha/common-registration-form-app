import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Reusable_Componets/form_dialog.dart';
import '../database/adding_data.dart';
import '../database/admin_database_methods.dart';

class UserDashboardScreen extends StatelessWidget {
  final String email;

  UserDashboardScreen({super.key, required this.email});

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final UserDatabaseMethods userDatabaseMethods = UserDatabaseMethods();
  final AdminDatabaseMethods adminDatabaseMethods = AdminDatabaseMethods();
  final TextEditingController customTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.pinkAccent.shade100,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => EditDialog(email: email),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder<Map<String, dynamic>?>(
              future: userDatabaseMethods.getUserDataByEmail(email),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Error fetching data"));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text("No data found"));
                } else {
                  final userData = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "User Basic Details:",
                            style: GoogleFonts.roboto(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Name: ${userData['Name']}",
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Email: ${userData['Email']}",
                            style: GoogleFonts.roboto(fontSize: 18),
                          ),
                          Text(
                            "PhoneNo: ${userData['PhoneNo']}",
                            style: GoogleFonts.roboto(fontSize: 18),
                          ),
                          Text(
                            "Designation: ${userData['Designation']}",
                            style: GoogleFonts.roboto(fontSize: 18),
                          ),
                          Text(
                            "Age: ${userData['Age']}",
                            style: GoogleFonts.roboto(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: adminDatabaseMethods.getFormData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Error fetching data"));
                } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No data found"));
                } else {
                  final formDataList = snapshot.data!;
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: formDataList.length,
                    itemBuilder: (context, index) {
                      final formData = formDataList[index];
                      String? title = formData['title'];
                      return ListTile(
                        title: Text("$title Form"),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => FormDialog(
                              formId: formData['id'], // Pass the form ID here
                              userEmail: email, // Pass the user's email here
                            ),
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}



// The rest of the EditDialog class remains unchanged.


class EditDialog extends StatefulWidget {
  final String email;

  EditDialog({required this.email});

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> controllers = [
    TextEditingController(), // Name controller
    TextEditingController(), // Email controller
    TextEditingController(), // mobile number controller
    TextEditingController(), // Designation controller
    TextEditingController(), // age controller
  ];
  final UserDatabaseMethods userDatabaseMethods = UserDatabaseMethods();

  @override
  void initState() {
    super.initState();
    _loadCurrentUserData();
  }

  Future<void> _loadCurrentUserData() async {
    final userData = await userDatabaseMethods.getUserDataByEmail(widget.email);
    if (userData != null) {
      setState(() {
        controllers[0].text = userData['Name'];
        controllers[1].text = userData['Email'];
        controllers[2].text = userData['PhoneNo'];
        controllers[3].text = userData['Designation'];
        controllers[4].text = userData['Age'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Basic Details',
          style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold)),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(controllers.length, (index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: controllers[index],
                  decoration: InputDecoration(
                    labelText: getLabelText(index),
                    icon: getIcon(index),
                  ),
                  keyboardType: getInputType(index),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
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
            if (_formKey.currentState!.validate()) {
              Map<String, dynamic> updatedUserDetails = {
                "Name": controllers[0].text,
                "Email": controllers[1].text,
                "PhoneNo": controllers[2].text,
                "Designation": controllers[3].text,
                "Age": controllers[4].text,
              };

              await userDatabaseMethods
                  .updateUserDetails(updatedUserDetails, widget.email)
                  .then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Details Updated Successfully"),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.blue,
                    showCloseIcon: true,
                  ),
                );
                Navigator.pop(context);
              });
            }
          },
          child: Text('Save', style: GoogleFonts.roboto()),
        ),
      ],
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
