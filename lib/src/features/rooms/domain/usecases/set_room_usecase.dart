import 'package:result_dart/result_dart.dart';
import 'package:room_agenda/src/core/core.dart';
import 'package:room_agenda/src/features/rooms/domain/entities/room_entity.dart';
import 'package:room_agenda/src/features/rooms/domain/repositories/imp_room_repository.dart';

class SetRoomUseCase implements UseCase<String, ParamsSetRoom> {
  final ImpRoomRepository repository;

  SetRoomUseCase({required this.repository});

  @override
  Future<Result<String, AppException>> call(ParamsSetRoom params) {
    return repository.setRoom(room: params.room);
  }
}

class ParamsSetRoom {
  final Room room;

  ParamsSetRoom({required this.room});
}
