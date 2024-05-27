import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseMethods {
  Future addUserBasicDetails(
      Map<String, dynamic> userBasicInfo, String id) async {
      await FirebaseFirestore.instance
        .collection("UserData")
        .doc(id)
        .set(userBasicInfo);
  }
}
