import 'package:result_dart/result_dart.dart';
import 'package:room_agenda/src/core/exceptions/app_exception.dart';
import 'package:room_agenda/src/core/usecases/usecase.dart';
import 'package:room_agenda/src/features/rooms/domain/repositories/room_imp_repository.dart';

class DeleteRoomUseCase implements UseCase<Unit, ParamsDeleteRoom> {
  final RoomImpRepository repository;

  DeleteRoomUseCase({required this.repository});

  @override
  Future<Result<Unit, AppException>> call(ParamsDeleteRoom params) {
    return repository.deleteRoom(
      hashCompany: params.hashCompany,
      hashRoom: params.hashRoom,
    );
  }
}

class ParamsDeleteRoom {
  final String hashCompany;
  final String hashRoom;

  ParamsDeleteRoom({
    required this.hashCompany,
    required this.hashRoom,
  });
}
