import 'package:zarity_health_assignment/data/workout.dart';

abstract class WorkoutState {}

class WorkoutLoadingState extends WorkoutState {}

class WorkoutLoadedState extends WorkoutState {
  List<Workout>? workouts;

  WorkoutLoadedState(this.workouts);
}

class WorkoutErrorState extends WorkoutState {
  final String error;

  WorkoutErrorState(this.error);
}
