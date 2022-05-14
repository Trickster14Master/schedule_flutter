import 'dart:convert';

List<Task> taskFromJson(String str) => List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String taskToJson(List<Task> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
    Task({
        required this.titlt,
        required this.description,
        required this.fromDate,
        required this.toDate,
        required this.status,
    });

    String titlt;
    String description;
    DateTime fromDate;
    DateTime toDate;
    int status;

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        titlt: json["titlt"],
        description: json["description"],
        fromDate: DateTime.parse(json["from_date"]),
        toDate: DateTime.parse(json["to_date"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "titlt": titlt,
        "description": description,
        "from_date": fromDate.toIso8601String(),
        "to_date": toDate.toIso8601String(),
        "status": status,
    };
}