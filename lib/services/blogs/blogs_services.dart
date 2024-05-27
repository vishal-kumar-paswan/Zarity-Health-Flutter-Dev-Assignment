import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zarity_health_assignment/data/blog.dart';
import 'package:zarity_health_assignment/utils/log_message.dart';

class BlogsServices {
  final _firestore = FirebaseFirestore.instance;

  // Fetch all blogs from firestore
  Future<List<Blog>> fetchBlogs() async {
    try {
      CollectionReference workoutCollectionRef = _firestore.collection('blogs');
      QuerySnapshot querySnapshot = await workoutCollectionRef.get();
      List<dynamic> blogs = querySnapshot.docs
          .map((task) => jsonDecode(jsonEncode(task.data())))
          .toList();

      return blogs.map((blog) => Blog.fromJson(blog)).toList();
    } catch (e) {
      LogMessage(e.toString());
      rethrow;
    }
  }
}
