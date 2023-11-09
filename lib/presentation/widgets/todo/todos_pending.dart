import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:busy_bee/presentation/widgets/todo/todo_list.dart';
import 'package:busy_bee/presentation/providers/todo_provider.dart';

class TodosPending extends ConsumerWidget {
  const TodosPending({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.read(todoProvider);

    return StreamBuilder(
      stream: todos.getByDone(false),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.error != null) {
          return const Center(
            child: Text('Some error occurred'),
          );
        }
        return TodoList(snapshot.data?.docs);
      },
    );
  }
}
