import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  String? id;
  String? title;
  String? description;
  bool completed;
  int? date;
  int? time;

  Todo({
    this.id,
    this.title,
    this.description,
    this.completed = false,
    this.date,
    this.time,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        completed,
        date,
        time,
      ];
}
