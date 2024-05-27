import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zarity_health_assignment/cubits/user_cubit/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserLoadingState()) {
    _fetchUserDetails();
  }

  void _fetchUserDetails() {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      emit(UserLoadedState(user));
    } on Exception catch (_) {
      emit(UserErrorState("Error occured, please try again later."));
    }
  }
}
