import '../../domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel({
    String? id,
    String? title,
    String? description,
    bool completed = false,
    num? timestamp,
  }) : super(
          id: id,
          title: title,
          description: description,
          completed: completed,
          timestamp: timestamp,
        );

  TodoModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    completed = json['completed'];
    timestamp = json['timestamp'];
  }

  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    bool completed = false,
    num? timestamp,
  }) =>
      TodoModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        completed: completed,
        timestamp: timestamp ?? this.timestamp,
      );

  TodoModel.fromObject({
    required Todo todo,
  }) {
    id = todo.id;
    title = todo.title;
    description = todo.description;
    completed = todo.completed;
    timestamp = todo.timestamp;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['completed'] = completed;
    map['timestamp'] = timestamp;
    return map;
  }
}
