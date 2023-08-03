import 'package:result_dart/result_dart.dart';
import 'package:room_agenda/src/core/core.dart';
import 'package:room_agenda/src/features/login/login.dart';

abstract class ImpLoginRepository {
  Future<Result<Usuario, AppException>> signIn();
}
