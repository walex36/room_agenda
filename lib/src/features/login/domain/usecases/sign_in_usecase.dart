import 'package:result_dart/src/result.dart';
import 'package:room_agenda/src/core/exceptions/app_exception.dart';
import 'package:room_agenda/src/core/usecases/usecase.dart';
import 'package:room_agenda/src/features/login/domain/entities/Usuario_entity.dart';
import 'package:room_agenda/src/features/login/domain/repositories/i_login_repository.dart';

class SignInUseCase extends UseCase<Usuario, NoParams> {
  final ILoginRepository _repository;

  SignInUseCase({required ILoginRepository repository})
      : _repository = repository;

  @override
  Future<Result<Usuario, AppException>> call(NoParams params) async {
    return await _repository.signIn();
  }
}
