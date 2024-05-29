import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDatabaseMethods {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  Future<bool> checkEmailExists() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection("UserData")
        .where("Email", isEqualTo: firebaseAuth.currentUser!.email.toString())
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> updateUserDetails(
      Map<String, dynamic> updatedUserDetails, String email) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection("UserData")
        .where("Email", isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;
      await FirebaseFirestore.instance
          .collection("UserData")
          .doc(docId)
          .update(updatedUserDetails);
    }
  }

  Future<void> addUserBasicDetails(
      Map<String, dynamic> userBasicInfo, String id) async {
    await FirebaseFirestore.instance
        .collection("UserData")
        .doc(id)
        .set(userBasicInfo);
  }

  Future<Map<String, dynamic>?> getUserDataByEmail(String email) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection("UserData")
        .where("Email", isEqualTo: firebaseAuth.currentUser!.email.toString())
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data();
    }
    return null;
  }
}

