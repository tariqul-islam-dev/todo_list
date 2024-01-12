import '../../domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel({
    String? id,
    String? title,
    String? description,
    bool completed = false,
    int? date,
    int? time,
  }) : super(
          id: id,
          title: title,
          description: description,
          completed: completed,
          date: date,
          time: time,
        );

  TodoModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    completed = json['completed'] == 1;
    date = json['date'];
    time = json['time'];
  }

  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    bool completed = false,
    int? date,
    int? time,
  }) =>
      TodoModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        completed: completed,
        date: date ?? this.date,
        time: time ?? this.time,
      );

  TodoModel.fromObject({
    required Todo todo,
  }) {
    id = todo.id;
    title = todo.title;
    description = todo.description;
    completed = todo.completed;
    date = todo.date;
    time = todo.time;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['completed'] = completed == true ? 1 : 0;
    map['date'] = date;
    map['time'] = time;
    return map;
  }
}
