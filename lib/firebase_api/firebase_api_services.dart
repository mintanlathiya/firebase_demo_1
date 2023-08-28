import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

class FirebaseApi1 {
  static final _db = FirebaseDatabase.instance.ref('User');
  static Future<void> addUser({
    required String userName,
    required String lastName,
    required String gender,
    required double selectedSalary,
    required List selectedHobbies,
    required bool isActive,
  }) async {
    String key = _db.push().key!;
    await _db.child(key).set({
      'key': key,
      'userName': userName,
      'lastName': lastName,
      'gender': gender,
      'hobby': selectedHobbies,
      'salary': selectedSalary,
      'active': isActive
    });
  }

  static Future<List<Map>> selectData() async {
    Map data =
        await _db.once().then((value) => value.snapshot.value as Map? ?? {});
    //log('$data');
    List<Map> userData = [];
    data.forEach((key, value) {
      log('$value');
      userData.add(value);
    });
    //log('$userData');
    return userData;
  }

  static Future<void> updateData({
    required String key,
    required String userName,
    required String lastName,
    required String gender,
    required List selectedHobbies,
    required double selectedSalary,
    required bool isActive,
  }) async {
    await _db.child(key).set({
      'key': key,
      'userName': userName,
      'lastName': lastName,
      'gender': gender,
      'hobby': selectedHobbies,
      'salary': selectedSalary,
      'active': isActive
    });
  }

  static Future<void> removeData({required String key}) async {
    await _db.child(key).remove();
  }
}
