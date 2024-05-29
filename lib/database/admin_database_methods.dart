import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDatabaseMethods {
  Future<void> addFormField(
      Map<String, dynamic> formFieldInfo, String Id) async {
      await FirebaseFirestore.instance
        .collection("FormsInfo")
        .doc(Id)
        .set(formFieldInfo);
  }
}
