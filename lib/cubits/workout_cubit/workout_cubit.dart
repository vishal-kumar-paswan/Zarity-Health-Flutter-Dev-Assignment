import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zarity_health_assignment/cubits/workout_cubit/workout_state.dart';
import 'package:zarity_health_assignment/data/workout.dart';
import 'package:zarity_health_assignment/services/workouts/workout_services.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(WorkoutLoadingState()) {
    _fetchWorkouts();
  }

  void _fetchWorkouts() async {
    try {
      List<Workout> workouts = await WorkoutServices().fetchWorkouts();
      emit(WorkoutLoadedState(workouts));
    } on Exception catch (_) {
      emit(WorkoutErrorState("Error occured, please try again later."));
    }
  }
}
