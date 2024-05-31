import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDatabaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addFormField(Map<String, dynamic> formFieldInfo, String id) async {
    await _firestore.collection("FormsInfo").doc(id).set(formFieldInfo);
  }

  Future<List<Map<String, dynamic>>> getFormData() async {
    final querySnapshot = await _firestore.collection("FormsInfo").get();
    return querySnapshot.docs.map((doc) => {
      'id': doc.id, // Include the document ID
      ...doc.data() as Map<String, dynamic>,
    }).toList();
  }

  Future<Map<String, dynamic>?> getFormFields(String formId) async {
    DocumentSnapshot doc = await _firestore.collection('FormsInfo').doc(formId).get();
    return doc.data() as Map<String, dynamic>?;
  }

  Future<void> addUserFormSubmission(
      String userEmail,
      String formId,
      Map<String, dynamic> formSubmissionData,
      Map<String, dynamic> userBasicDetails
      ) async {
    await _firestore.collection("UserFormSubmit").add({
      'userEmail': userEmail,
      'formId': formId,
      'submission': formSubmissionData,
      'userBasicDetails': userBasicDetails,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
