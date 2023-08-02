import 'package:result_dart/result_dart.dart';
import 'package:room_agenda/src/core/exceptions/app_exception.dart';
import 'package:room_agenda/src/features/login/domain/entities/Usuario_entity.dart';

abstract class ILoginRepository {
  Future<Result<Usuario, LoginException>> signIn();
}
