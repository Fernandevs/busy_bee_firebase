import 'package:busy_bee/presentation/helpers/util.dart';

class Todo {
  String title;
  String description;
  DateTime datetime;
  String note;
  int color;
  bool done;
  String char;

  Todo({
    required this.title,
    required this.description,
    required this.datetime,
    this.note = '',
    required this.color,
    this.done = false,
    required this.char,
  });

  factory Todo.fromJson(Map<String, dynamic> map) => Todo(
        title: map['title'],
        description: map['description'],
        datetime: map['datetime'],
        note: map['note'],
        color: map['color'],
        done: map['done'],
        char: map['char'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'datetime': datetime,
        'note': note,
        'color': color,
        'done': done,
        'char': char,
      };
}
