import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:room_agenda/src/core/core.dart';
import 'package:room_agenda/src/features/login/login.dart';

class LoginProvider extends ChangeNotifier {
  final SignInUseCase _signInUseCase;

  LoginProvider({
    required SignInUseCase signInUseCase,
  }) : _signInUseCase = signInUseCase;

  Future<void> onSignIn() async {
    final userOrFailure = await _signInUseCase(NoParams());

    userOrFailure.fold(
      (user) {
        Modular.to.pushReplacementNamed(RouterConst.company(), arguments: {
          'usuario': user,
        });
      },
      (failure) {
        print(failure);
      },
    );
  }
}
