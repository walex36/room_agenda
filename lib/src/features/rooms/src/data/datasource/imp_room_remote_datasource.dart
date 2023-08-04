import 'package:result_dart/result_dart.dart';
import 'package:room_agenda/src/features/rooms/rooms.dart';

abstract class ImpRoomRemoteDataSource {
  Future<List<RoomModel>> getRooms({
    required String hashCompany,
  });

  Future<String> setRoom({
    required RoomModel roomModel,
  });

  Future<Unit> updateRoom({
    required String hashCompany,
    required String hashRoom,
    required Map<String, dynamic> room,
  });

  Future<Unit> deleteRoom({
    required String hashCompany,
    required String hashRoom,
  });
}
