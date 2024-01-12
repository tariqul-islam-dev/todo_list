import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  String? id;
  String? title;
  String? description;
  bool completed;
  num? timestamp;

  Todo({
    this.id,
    this.title,
    this.description,
    this.completed = false,
    this.timestamp,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        completed,
        timestamp,
      ];
}
