import 'package:result_dart/result_dart.dart';
import 'package:room_agenda/src/core/exceptions/app_exception.dart';
import 'package:room_agenda/src/features/rooms/domain/entities/room_entity.dart';

abstract class RoomImpRepository {
  Future<Result<List<Room>, RoomException>> getListRooms({
    required String hashCompany,
  });

  Future<Result<String, RoomException>> setRoom({
    required Room room,
  });

  Future<Result<Unit, RoomException>> updateRoom({
    required Room roomOld,
    required Room roomNew,
  });

  Future<Result<Unit, RoomException>> deleteRoom({
    required String hashCompany,
    required String hashRoom,
  });
}
