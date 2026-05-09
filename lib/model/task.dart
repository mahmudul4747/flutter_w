class Task {
  String title;
  bool isDone;
  String date;

  Task(this.title, {this.isDone = false, required this.date});

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "isDone": isDone,
      "date": date,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      json["title"],
      isDone: json["isDone"],
      date: json["date"],
    );
  }
}
