import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_application/database/adding_data.dart';

class DashboardScreen extends StatelessWidget {
  final String email;

   DashboardScreen({super.key, required this.email});
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  final UserDatabaseMethods userDatabaseMethods=UserDatabaseMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: userDatabaseMethods.getUserDataByEmail(email),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error fetching data"));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text("No data found"));
          } else {
            final userData = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: ${userData['Name']}"),
                  Text("Email: ${userData['Email']}"),
                  Text("PhoneNo: ${userData['PhoneNo']}"),
                  Text("Designation: ${userData['Designation']}"),
                  Text("Age: ${userData['Age']}"),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
