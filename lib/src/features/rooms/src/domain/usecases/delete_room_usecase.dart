import 'package:result_dart/result_dart.dart';
import 'package:room_agenda/src/core/core.dart';
import 'package:room_agenda/src/features/rooms/rooms.dart';

class DeleteRoomUseCase implements UseCase<Unit, ParamsDeleteRoom> {
  final ImpRoomRepository repository;

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
