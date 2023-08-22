import 'package:firebase_database/firebase_database.dart';

class FirebaseApi {
  static final _db = FirebaseDatabase.instance.ref('User');
  static Future<void> addUser({required String userName}) async {
    await _db.set(userName);
  }
}
