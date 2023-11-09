import 'package:busy_bee/presentation/providers/notification_provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:busy_bee/presentation/providers/auth_provider.dart';
import 'package:busy_bee/presentation/widgets/todo/todos_done.dart';
import 'package:busy_bee/presentation/widgets/todo/todos_pending.dart';
import 'package:busy_bee/presentation/widgets/todo/todos_all.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authenticationProvider = ref.watch(authProvider);
    final notificationsProvider = ref.watch(notificationProvider);

    notificationsProvider.initNotification();

    if (!authenticationProvider.loggedIn) {
      context.goNamed('login');
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white12,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.pending_actions)),
              Tab(icon: Icon(Icons.done)),
              Tab(icon: Icon(Icons.checklist)),
            ],
          ),
          title: const Text('Busy Bee'),
          centerTitle: true,
          elevation: 20,
        ),
        body: const TabBarView(
          children: <Widget>[
            TodosPending(),
            TodosDone(),
            TodosAll(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amberAccent,
          onPressed: () {
            context.goNamed('todo_add');
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
