import 'package:firebase_auth/firebase_auth.dart';

abstract class UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  User? user;

  UserLoadedState(this.user);
}

class UserErrorState extends UserState {
  final String error;

  UserErrorState(this.error);
}
