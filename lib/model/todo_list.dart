import 'package:todo_aoo/utils.dart';

class TodoField {
  static const timeCreated = 'timeCreated';
}

class TodoList {
  DateTime? timeCreated;
  String title;
  String id;
  String description;
  // bool isDone

  TodoList({
    required this.timeCreated,
    required this.id,
    this.title = '',
    this.description = '',
  });

  static TodoList fromJson(Map<String, dynamic> json) => TodoList(
        timeCreated: Utils.toDateTime(json['timeCreated']),
        title: json['title'],
        description: json['description'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'id': id,
        'timeCreated': Utils.fromDateTimeToJson(timeCreated!),
      };
}
