import 'package:busy_bee/presentation/providers/notification_provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:busy_bee/presentation/providers/todo_provider.dart';
import 'package:busy_bee/presentation/widgets/todo/todo_form.dart';

class TodoAdd extends ConsumerWidget {
  const TodoAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosProvider = ref.watch(todoProvider);
    final notificationsProvider = ref.watch(notificationProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white12,
        centerTitle: true,
      ),
      body: TodoForm(
        onPressed: (todo) {
          todosProvider.add(todo);
          context.goNamed('home');
          notificationsProvider.showNotification(todo);
        },
      ),
    );
  }
}
