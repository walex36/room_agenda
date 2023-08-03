import 'package:result_dart/result_dart.dart';
import 'package:room_agenda/src/core/core.dart';
import 'package:room_agenda/src/features/login/login.dart';

class SignInUseCase implements UseCase<Usuario, NoParams> {
  final ImpLoginRepository _repository;

  SignInUseCase({required ImpLoginRepository repository})
      : _repository = repository;

  @override
  Future<Result<Usuario, AppException>> call(NoParams params) async {
    return await _repository.signIn();
  }
}
