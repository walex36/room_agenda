import 'package:firebase_auth/firebase_auth.dart';
import 'package:room_agenda/src/features/login/src/data/models/usuario_model.dart';

abstract class ImpLoginRemoteDatasource {
  Future<UserCredential> signInGoogle();

  Future<UsuarioModel> signIn({
    required UserCredential userCredential,
  });
}
