class Blog {
  String? title;
  String? description;
  String? image;
  String? date;

  Blog({this.title, this.description, required this.image, required this.date});

  Blog.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image_url'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['description'] = description;
    data['image_url'] = image;
    data['date'] = date;
    return data;
  }
}
