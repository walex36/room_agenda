import 'package:flutter/material.dart';
import 'package:room_agenda/src/features/login/services/firebase_service_auth.dart';

class LoginProvider extends ChangeNotifier {
  final _fAuth = FirebaseServiceAuth();

  Future<void> onSignIn() async {
    final user = await _fAuth.signInWithGoogle();
  }
}
