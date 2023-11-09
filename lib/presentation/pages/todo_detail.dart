import 'package:flutter/material.dart';

import 'package:busy_bee/data/models/todo.dart';
import 'package:busy_bee/presentation/widgets/todo/todo_form.dart';

class TodoDetail extends StatelessWidget {
  final Todo todo;

  const TodoDetail({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white12,
        centerTitle: true,
      ),
      body: TodoForm(
        todo: todo,
        viewMode: true,
      ),
    );
  }
}
