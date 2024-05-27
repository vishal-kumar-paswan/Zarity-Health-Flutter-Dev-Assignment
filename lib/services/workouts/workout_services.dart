import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zarity_health_assignment/data/workout.dart';
import 'package:zarity_health_assignment/utils/log_message.dart';

class WorkoutServices {
  final _firestore = FirebaseFirestore.instance;

  // Fetch all workouts from the firestore
  Future<List<Workout>> fetchWorkouts() async {
    try {
      CollectionReference workoutCollectionRef =
          _firestore.collection('workouts');
      QuerySnapshot querySnapshot = await workoutCollectionRef.get();
      List<dynamic> workouts = querySnapshot.docs
          .map((task) => jsonDecode(jsonEncode(task.data())))
          .toList();

      return workouts.map((workout) => Workout.fromJson(workout)).toList();
    } catch (e) {
      LogMessage(e.toString());
      rethrow;
    }
  }
}
