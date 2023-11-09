import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:busy_bee/data/models/todo.dart';
import 'package:busy_bee/presentation/pages/home_page.dart';
import 'package:busy_bee/presentation/pages/login_page.dart';
import 'package:busy_bee/presentation/pages/todo_add.dart';
import 'package:busy_bee/presentation/pages/todo_detail.dart';
import 'package:busy_bee/presentation/pages/todo_edit.dart';

final router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) => const HomePage(),
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          name: 'login',
          builder: (BuildContext context, GoRouterState state) => const LoginPage(),
        ),
        GoRoute(
          path: 'todo_detail',
          name: 'todo_detail',
          builder: (BuildContext context, GoRouterState state) {
            Todo todo = state.extra as Todo;
            return TodoDetail(todo: todo);
          },
        ),
        GoRoute(
          path: 'todo_edit',
          name: 'todo_edit',
          builder: (BuildContext context, GoRouterState state) {
            Map<String, dynamic> values = state.extra as Map<String, dynamic>;
            Todo todo = values['todo'];
            String id = values['id'];

            return TodoEdit(id: id, todo: todo);
          },
        ),
        GoRoute(
          path: 'todo_add',
          name: 'todo_add',
          builder: (BuildContext context, GoRouterState state) => const TodoAdd(),
        ),
      ],
    ),
  ],
);
