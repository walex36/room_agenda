import 'package:result_dart/result_dart.dart';
import 'package:room_agenda/src/core/exceptions/app_exception.dart';
import 'package:room_agenda/src/core/usecases/usecase.dart';
import 'package:room_agenda/src/features/rooms/domain/entities/room_entity.dart';
import 'package:room_agenda/src/features/rooms/domain/repositories/room_imp_repository.dart';

class UpdateRoomUseCase implements UseCase<Unit, ParamsUpdateRoom> {
  final RoomImpRepository repository;

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
