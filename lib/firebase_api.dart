import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FirebaseApi {
  static final db = FirebaseDatabase.instance.ref('User');
  static String selectedKey = '';
  static TextEditingController txtUpdateFname = TextEditingController();
  static TextEditingController txtUpdateMname = TextEditingController();
  static TextEditingController txtUpdateLname = TextEditingController();
  static bool isCricket = false,
      isFootball = false,
      isSinging = false,
      isDriving = false;

  static Future<void> userData({
    required String fname,
    required String mname,
    required String lname,
    required String gender,
    required List<String> hobbey,
  }) async {
    String key = db.push().key!;
    await db.child(key).set({
      'key': key,
      'fname': fname,
      'mname': mname,
      'lname': lname,
      'hobbey': List.from(hobbey.map((e) => e)),
      'gender': gender,
    });
  }

  static Future<List<Map>> selectData() async {
    Map data =
        await db.once().then((value) => value.snapshot.value as Map? ?? {});

    List<Map> userData = [];
    data.forEach((key, value) {
      userData.add(value);
    });
    return userData;
  }

  static Future<void> updateUserData({
    required String key,
    required String fname,
    required String mname,
    required String lname,
    required String gender,
    required List hobbey,
  }) async {
    await db.child(key).update({
      'key': key,
      'fname': fname,
      'mname': mname,
      'lname': lname,
      'gender': gender,
      'hobbey': List.from(hobbey.map((e) => e)),
    });
  }

  static Future<void> deleteUserData({required String key}) async {
    await db.child(key).remove();
  }
}
