import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:room_agenda/src/features/login/login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Modular.get<LoginProvider>();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton.icon(
              onPressed: () => loginProvider.onSignIn(),
              icon: Icon(Icons.login),
              label: Text('Login'),
            ),
          )
        ],
      ),
    );
  }
}
