import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zarity_health_assignment/cubits/blogs_cubit/blogs_state.dart';
import 'package:zarity_health_assignment/data/blog.dart';
import 'package:zarity_health_assignment/services/blogs/blogs_services.dart';

class BlogsCubit extends Cubit<BlogsState> {
  BlogsCubit() : super(BlogsLoadingState()) {
    _fetchBlogs();
  }

  void _fetchBlogs() async {
    try {
      List<Blog> blogs = await BlogsServices().fetchBlogs();
      emit(BlogsLoadedState(blogs));
    } on Exception catch (_) {
      emit(BlogsErrorState("Error occured, please try again later."));
    }
  }
}
