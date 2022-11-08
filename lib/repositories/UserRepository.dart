import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart' as app_user;

class UserRepository {
  Future<String?> registerUser(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.code}");
      return e.code;
    } on FirebaseException catch (e) {
      print("FirebaseException: ${e.code}");
      return e.code;
    }
  }

  Future<String?> createUser(app_user.User user) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(user.uid).set(user.toJson());
      return user.uid;
    } on FirebaseException catch (e) {
      print("FirebaseException: ${e.code}");
      return e.code;
    }
  }
}