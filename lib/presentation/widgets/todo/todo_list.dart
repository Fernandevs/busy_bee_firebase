import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:busy_bee/data/models/todo.dart';
import 'package:busy_bee/presentation/widgets/shared/nothing_to_show.dart';
import 'package:busy_bee/presentation/widgets/todo/todo_item.dart';

class TodoList extends ConsumerWidget {
  final List<QueryDocumentSnapshot> _todos;
  final bool? pending;

  const TodoList(this._todos, {Key? key, this.pending}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _todos.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.only(
              top: 5,
              left: 10,
              right: 10,
            ),
            itemCount: _todos.length,
            itemBuilder: (context, index) {
              final todoSnapshot = _todos[index];
              final String id = todoSnapshot.id;
              final String title = todoSnapshot.get('title');
              final String description = todoSnapshot.get('description');
              final DateTime datetime = todoSnapshot.get('datetime').toDate();
              final String note = todoSnapshot.get('note');
              final int color = todoSnapshot.get('color');
              final bool done = todoSnapshot.get('done');
              final String char = todoSnapshot.get('char');

              return TodoItem(
                id: id,
                index: index,
                todo: Todo(
                  title: title,
                  description: description,
                  datetime: datetime,
                  note: note,
                  color: color,
                  done: done,
                  char: char,
                ),
                pending: pending ?? false,
              );
            },
          )
        : const NothingToShow();
  }
}
