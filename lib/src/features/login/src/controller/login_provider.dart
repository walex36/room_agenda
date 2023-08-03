import 'package:flutter/material.dart';
import 'package:room_agenda/src/core/src/usecases/usecase.dart';
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
        print(user);
      },
      (failure) {
        print(failure);
      },
    );
  }
}
