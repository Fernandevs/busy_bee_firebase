import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:busy_bee/data/models/todo.dart';
import 'package:busy_bee/presentation/providers/todo_provider.dart';
import 'package:busy_bee/presentation/widgets/todo/todo_form.dart';

class TodoEdit extends ConsumerWidget {
  final String id;
  final Todo todo;

  const TodoEdit({
    Key? key,
    required this.id,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(todoProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white12,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: TodoForm(
          todo: todo,
          viewMode: false,
          onPressed: (todo) {
            provider.edit(id, todo);
            context.goNamed('home');
          },
        ),
      ),
    );
  }
}
