import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zarity_health_assignment/services/tasks/tasks_services.dart';
import 'package:zarity_health_assignment/utils/log_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationServices {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // Sign in user
  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } on Exception catch (e) {
      LogMessage(e.toString());
      rethrow;
    }
  }

  // Sign out user
  Future<bool> signOutFromGoogle() async {
    try {
      await _auth.signOut();
      return true;
    } on Exception catch (e) {
      LogMessage(e.toString());
      return false;
    }
  }

  //  Checking if user exists in database
  Future<bool> checkUserExists(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();
      if (documentSnapshot.exists) {
        return true;
      }
      return false;
    } on Exception catch (e) {
      LogMessage(e.toString());
      rethrow;
    }
  }

  Future<void> storeUserData(String userId, String email, String name) async {
    // Fetch tasks and add it to the current user instance
    List<dynamic> tasks = await TasksServices().fetchTasks();
    _firestore
        .collection('users')
        .doc(userId)
        .set(
          {
            "email": email,
            "name": name,
            "tasks": tasks,
          },
        )
        .then((value) => LogMessage("User added"))
        .onError((error, stackTrace) => LogMessage("Failed to add user"));
  }
}
