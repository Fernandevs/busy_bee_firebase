import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

class _Auth {
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  login(String emailInput, String passInput) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailInput,
        password: passInput,
      );

      if (userCredential.user != null){
        _loggedIn = true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No se encontró ningún usuario para ese correo electrónico.');
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Se proporcionó una contraseña incorrecta para ese usuario.');
        }
      }
    }
  }
}

final authProvider = Provider((ref) => _Auth());
