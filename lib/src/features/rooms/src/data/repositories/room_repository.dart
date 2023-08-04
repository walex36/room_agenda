import 'package:result_dart/result_dart.dart';
import 'package:room_agenda/src/core/core.dart';
import 'package:room_agenda/src/features/rooms/rooms.dart';

class RoomRepository implements ImpRoomRepository {
  final ImpRoomRemoteDataSource _dataSourceRemote;

  RoomRepository({
    required ImpRoomRemoteDataSource dataSourceRemote,
  }) : _dataSourceRemote = dataSourceRemote;

  @override
  Future<Result<Unit, RoomException>> deleteRoom({
    required String hashCompany,
    required String hashRoom,
  }) async {
    try {
      await _dataSourceRemote.deleteRoom(
        hashCompany: hashCompany,
        hashRoom: hashRoom,
      );

      return const Success(unit);
    } on RoomException catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<List<Room>, RoomException>> getListRooms({
    required String hashCompany,
  }) async {
    try {
      final result = await _dataSourceRemote.getRooms(
        hashCompany: hashCompany,
      );

      return Success(List<Room>.from(result.map((r) => r.toEntity())));
    } on RoomException catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<String, RoomException>> setRoom({
    required Room room,
  }) async {
    try {
      final result = await _dataSourceRemote.setRoom(
        roomModel: RoomModel.fromEntity(room),
      );

      return Success(result);
    } on RoomException catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<Unit, RoomException>> updateRoom({
    required Room roomOld,
    required Room roomNew,
  }) async {
    try {
      final result = await _dataSourceRemote.updateRoom(
          hashCompany: roomOld.hashCompany,
          hashRoom: roomOld.hash,
          room: RoomModel.fromEntity(roomNew).toMapFirestoreUpdate(
            roomOld: RoomModel.fromEntity(roomOld),
          ));

      return Success(result);
    } on RoomException catch (e) {
      return Failure(e);
    }
  }
}
