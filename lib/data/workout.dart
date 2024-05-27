class Workout {
  String? title;
  String? image;
  Workout({
    this.title,
    this.image,
  });

  Workout.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['image'] = image;
    return data;
  }
}
