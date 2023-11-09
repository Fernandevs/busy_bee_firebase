import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:busy_bee/data/models/todo.dart';
import 'package:busy_bee/presentation/helpers/util.dart';
import 'package:busy_bee/presentation/providers/todo_provider.dart';

class TodoItem extends ConsumerWidget {
  final String id;
  final int index;
  final Todo todo;
  final bool pending;

  const TodoItem({
    Key? key,
    required this.id,
    required this.index,
    required this.todo,
    required this.pending,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(todoProvider);

    return Dismissible(
      key: ValueKey<int>(index),
      direction: DismissDirection.horizontal,
      background: Container(
        color: !pending? Colors.green : Colors.deepPurpleAccent,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                width: 20,
              ),
              Text(!pending? 'Terminar' : 'Incompleto'),
              const SizedBox(
                width: 20,
              ),
              !pending? const Icon(Icons.task_alt, color: Colors.white)
                  : const Icon(Icons.task, color: Colors.white),
            ],
          ),
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const <Widget>[
              SizedBox(
                width: 20,
              ),
              Text('Eliminar'),
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          final bool? result = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("¿Está seguro de eliminar ${todo.title}?"),
                actions: <Widget>[
                  TextButton(
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text(
                      "Eliminar",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      provider.remove(id);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
          return result ?? false;
        } else {
          final bool? result = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text(
                  "¿Está seguro de cambiar el estado de ${todo.title}?",
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text(
                      "Confirmar",
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: () {
                      todo.done = !pending;
                      provider.edit(id, todo);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
          return result ?? false;
        }
      },
      child: Card(
        elevation: 20,
        child: ListTile(
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              context.goNamed(
                'todo_edit',
                extra: {
                  'id': id,
                  'todo': todo,
                }
              );
            },
          ),
          leading: CircleAvatar(
            backgroundColor: Color(todo.color),
            child: Text(todo.char),
          ),
          title: Text(todo.title),
          subtitle: Text(todo.description),
          onTap: () {
            context.goNamed('todo_detail', extra: todo);
          },
        ),
      ),
    );
  }
}
