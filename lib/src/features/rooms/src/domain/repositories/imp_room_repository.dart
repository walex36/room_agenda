import 'package:result_dart/result_dart.dart';
import 'package:room_agenda/src/core/core.dart';
import 'package:room_agenda/src/features/rooms/rooms.dart';

abstract class ImpRoomRepository {
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
