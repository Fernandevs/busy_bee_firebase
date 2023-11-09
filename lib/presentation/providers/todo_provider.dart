import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:busy_bee/data/models/todo.dart';

class _Todo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _todos;

  Stream getAll() =>
      _firestore
          .collection('todos')
          .snapshots();

  Stream getByDone(bool done) =>
      _firestore
          .collection('todos')
          .where('done', isEqualTo: done)
          .snapshots();

  Future<bool> add(Todo todo) async {
    _todos = _firestore.collection('todos');

    try {
      await _todos.add(todo.toJson());
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> remove(String id) async {
    _todos = _firestore.collection('todos');
    try {
      await _todos.doc(id).delete();
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> edit(String id, Todo todo) async {
    _todos = _firestore.collection('todos');
    try {
      await _todos.doc(id).update(todo.toJson());
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }
}

final todoProvider = Provider((ref) => _Todo());
