import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FireBaseApi {
  static TextEditingController txtUpdateFnameController =
      TextEditingController();
  static TextEditingController txtUpdateMnameController =
      TextEditingController();
  static TextEditingController txtUpdateLnameController =
      TextEditingController();
  static String gender = 'gender', male = 'male', female = 'female';
  static String selectedKey = '';

  static final db = FirebaseDatabase.instance.ref('user');

  static Future<void> userData({
    required String fname,
    required String lname,
    required String mname,
    required List<String> hobbey,
    required String gender,
  }) async {
    String key = db.push().key!;
    await db.child(key).set({
      'fname': fname,
      'mname': mname,
      'lname': lname,
      'hobbey': hobbey,
      'gender': gender,
      'key': key,
    });
  }

  static Future<List<Map>> selectUserData() async {
    Map data =
        await db.once().then((value) => value.snapshot.value as Map? ?? {});
    List<Map> userData = [];
    data.forEach((key, value) {
      userData.add(value);
    });
    return userData;
  }

  static void updateUserData({
    required String fname,
    required String key,
    required String mname,
    required String lname,
    required List<String> hobbey,
    required String gender,
  }) {
    db.child(key).update({
      'fname': fname,
      'mname': mname,
      'lname': lname,
      'hobbey': hobbey,
      'gender': gender,
      'key': key,
    });
  }
}
