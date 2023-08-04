import 'package:result_dart/result_dart.dart';
import 'package:room_agenda/src/core/core.dart';
import 'package:room_agenda/src/features/rooms/rooms.dart';

class UpdateRoomUseCase implements UseCase<Unit, ParamsUpdateRoom> {
  final ImpRoomRepository repository;

  UpdateRoomUseCase({required this.repository});

  @override
  Future<Result<Unit, AppException>> call(ParamsUpdateRoom params) {
    return repository.updateRoom(
      roomOld: params.roomOld,
      roomNew: params.roomNew,
    );
  }
}

class ParamsUpdateRoom {
  final Room roomOld;
  final Room roomNew;

  ParamsUpdateRoom({
    required this.roomOld,
    required this.roomNew,
  });
}
