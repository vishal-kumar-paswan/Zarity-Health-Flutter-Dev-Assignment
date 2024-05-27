class Task {
  String? task;
  String? description;
  bool? completed;

  Task({this.task, this.description, this.completed});

  Task.fromJson(Map<String, dynamic> json) {
    task = json['task'];
    description = json['description'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['task'] = task;
    data['description'] = description;
    data['completed'] = completed;
    return data;
  }
}
