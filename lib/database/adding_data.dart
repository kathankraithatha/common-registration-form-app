import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseMethods {
  
   Future<bool> checkEmailExists(String email)async{
     final querySnapshot=await FirebaseFirestore.instance.collection("UserData").where("Email", isEqualTo: email).get();
     return querySnapshot.docs.isNotEmpty;
   }
  Future addUserBasicDetails(
      Map<String, dynamic> userBasicInfo, String id) async {
      await FirebaseFirestore.instance
        .collection("UserData")
        .doc(id)
        .set(userBasicInfo);
  }
}

