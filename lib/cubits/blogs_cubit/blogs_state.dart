import 'package:zarity_health_assignment/data/blog.dart';

abstract class BlogsState {}

class BlogsLoadingState extends BlogsState {}

class BlogsLoadedState extends BlogsState {
  List<Blog> blogs;

  BlogsLoadedState(this.blogs);
}

class BlogsErrorState extends BlogsState {
  final String error;

  BlogsErrorState(this.error);
}
