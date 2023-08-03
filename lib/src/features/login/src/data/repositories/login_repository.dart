import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:result_dart/result_dart.dart';
import 'package:room_agenda/src/core/core.dart';
import 'package:room_agenda/src/features/login/login.dart';

class LoginRepository implements ImpLoginRepository {
  final ImpLoginRemoteDatasource _loginRemoteDatasource;

  LoginRepository({required ImpLoginRemoteDatasource loginRemoteDatasource})
      : _loginRemoteDatasource = loginRemoteDatasource;

  @override
  Future<Result<Usuario, AppException>> signIn() async {
    try {
      final userCredential = await _loginRemoteDatasource.signInGoogle();

      final usuarioModel = await _loginRemoteDatasource.signIn(
        userCredential: userCredential,
      );

      return Success(usuarioModel.toEntity());
    } on FirebaseException catch (e, stacktrace) {
      return Failure(LoginException(e.message!, stacktrace));
    }
  }
}
