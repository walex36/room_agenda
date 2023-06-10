// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/src/result.dart';
import 'package:result_dart/src/unit.dart';

import 'package:room_agenda/src/core/exceptions/app_exception.dart';
import 'package:room_agenda/src/features/rooms/data/datasource/room_imp_remote_datasource.dart';
import 'package:room_agenda/src/features/rooms/data/models/room_model.dart';
import 'package:room_agenda/src/features/rooms/domain/entities/room_entity.dart';
import 'package:room_agenda/src/features/rooms/domain/repositories/room_imp_repository.dart';

class RoomRepository implements RoomImpRepository {
  final RoomImpRemoteDataSource _dataSourceRemote;

  RoomRepository({
    required RoomImpRemoteDataSource dataSourceRemote,
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
