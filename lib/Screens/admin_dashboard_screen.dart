import 'package:flutter/material.dart';
import 'package:form_application/database/admin_database_methods.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final AdminDatabaseMethods adminDatabaseMethods = AdminDatabaseMethods();
  List<Map<String, dynamic>> submissions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSubmissions();
  }

  Future<void> fetchSubmissions() async {
    final fetchedSubmissions = await adminDatabaseMethods.getUserFormSubmissions();
    for (var submission in fetchedSubmissions) {
      final formId = submission['formId'];
      final formTitle = await adminDatabaseMethods.getFormTitle(formId);
      submission['formTitle'] = formTitle;
    }
    setState(() {
      submissions = fetchedSubmissions;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: GoogleFonts.roboto(color: Colors.white),
        ),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      backgroundColor: Colors.grey.shade100,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: submissions.length,
        itemBuilder: (context, index) {
          final submission = submissions[index];
          return SingleChildScrollView(
            child: Card(
              elevation: 6,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Form Title: ${submission['formTitle']}",
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:Colors.pinkAccent.shade700
                      ),

                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "User Basic Details:",
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ...submission['userBasicDetails'].entries.map<Widget>(
                          (entry) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Text(
                          "${entry.key}: ${entry.value}",
                          style: GoogleFonts.roboto(fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "Submission:",
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ...submission['submission'].entries.map<Widget>(
                          (entry) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Text(
                          "${entry.key}: ${entry.value}",
                          style: GoogleFonts.roboto(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
