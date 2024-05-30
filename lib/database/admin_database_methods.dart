import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDatabaseMethods {
  Future<void> addFormField(Map<String, dynamic> formFieldInfo, String id) async {
    await FirebaseFirestore.instance
        .collection("FormsInfo")
        .doc(id)
        .set(formFieldInfo);
  }

  Future<List<Map<String, dynamic>>> getFormData() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection("FormsInfo")
        .get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }


}
