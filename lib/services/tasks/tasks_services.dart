import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zarity_health_assignment/data/task.dart';
import 'package:zarity_health_assignment/utils/display_message.dart';
import 'package:zarity_health_assignment/utils/log_message.dart';

class TasksServices {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // fetch task list from firebase
  Future<List<dynamic>> fetchTasks() async {
    try {
      CollectionReference tasksCollectionRef = _firestore.collection('tasks');
      QuerySnapshot querySnapshot = await tasksCollectionRef.get();
      List<dynamic> tasks = querySnapshot.docs
          .map((task) => jsonDecode(jsonEncode(task.data())))
          .toList();
      return tasks;
    } catch (e) {
      LogMessage(e.toString());
      rethrow;
    }
  }

  // fetch task list from firebase
  Future<List<Task>> fetchUserTasks() async {
    try {
      DocumentSnapshot userData = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      List<dynamic> tasks = jsonDecode(jsonEncode(userData.data()))['tasks'];
      return tasks.map((task) => Task.fromJson(task)).toList();
    } catch (e) {
      LogMessage(e.toString());
      rethrow;
    }
  }

  // fetch task list from firebase
  void updateTask(List<Task> tasks) async {
    List<dynamic> tasksJson = tasks.map((e) => e.toJson()).toList();

    _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .update({'tasks': tasksJson}).then(
      (_) {
        LogMessage('Task updated');
        DisplayMessage.showToast("Task updated!", 3);
      },
    ).catchError(
      (error) {
        LogMessage('Failed to update task');
        DisplayMessage.showToast("Task update failed!", 3);
      },
    );
  }
}
