import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:room_agenda/src/core/src/const/firestore_const.dart';
import 'package:room_agenda/src/core/src/exceptions/app_exception.dart';
import 'package:room_agenda/src/features/login/login.dart';

class LoginFirebaseDatasource implements ImpLoginRemoteDatasource {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<UsuarioModel> signIn({
    required UserCredential userCredential,
  }) async {
    const textError = 'Erro ao buscar usuario';
    try {
      final doc = await _db
          .collection(FirestoreConst.usuarios())
          .doc(userCredential.user!.email!)
          .get();

      if (doc.exists) {
        return UsuarioModel.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        final usuarioModel = UsuarioModel(
          name: userCredential.user!.displayName!,
          email: userCredential.user!.email!,
          photoUrl: userCredential.user!.photoURL!,
          cnpjs: const [],
        );

        await _db
            .collection(FirestoreConst.usuarios())
            .doc(userCredential.user!.email!)
            .set(usuarioModel.toMap());

        return usuarioModel;
      }
    } on FirebaseException catch (e, stacktrace) {
      throw LoginException(e.message ?? textError, stacktrace);
    }
  }

  @override
  Future<UserCredential> signInGoogle() async {
    const textError = 'Erro ao fazer login com o Google';
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await auth.signInWithCredential(credential);
    } on FirebaseException catch (e, stacktrace) {
      throw LoginException(e.message ?? textError, stacktrace);
    }
  }
}
