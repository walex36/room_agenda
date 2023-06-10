import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:result_dart/src/unit.dart';
import 'package:room_agenda/src/core/const/firestore_const.dart';
import 'package:room_agenda/src/core/exceptions/app_exception.dart';
import 'package:room_agenda/src/features/rooms/data/datasource/room_imp_remote_datasource.dart';
import 'package:room_agenda/src/features/rooms/data/models/room_model.dart';

class RoomFirestoreDataSource implements RoomImpRemoteDataSource {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<Unit> deleteRoom({
    required String hashCompany,
    required String hashRoom,
  }) async {
    const textError = 'Erro ao remover sala';
    try {
      await _db
          .collection(FirestoreConst.company())
          .doc(hashCompany)
          .collection(FirestoreConst.rooms())
          .doc(hashRoom)
          .update({
        'ativo': false,
      });
      return unit;
    } on FirebaseException catch (e, stacktrace) {
      throw RoomException(e.message ?? textError, stacktrace);
    }
  }

  @override
  Future<List<RoomModel>> getRooms({
    required String hashCompany,
  }) async {
    const textError = 'Erro ao buscar lista de salas';
    try {
      final roomsMap = await _db
          .collection(FirestoreConst.company())
          .doc(hashCompany)
          .collection(FirestoreConst.rooms())
          .where('ativo', isEqualTo: true)
          .get();

      return List<RoomModel>.from(roomsMap.docs.map(
        (e) => RoomModel.fromMapFirestore(
          e.data(),
          hash: e.id,
          hashCompany: hashCompany,
        ),
      ));
    } on FirebaseException catch (e, stacktrace) {
      throw RoomException(e.message ?? textError, stacktrace);
    }
  }

  @override
  Future<String> setRoom({
    required RoomModel roomModel,
  }) async {
    const textError = 'Erro ao criar sala';
    try {
      final doc = await _db
          .collection(FirestoreConst.company())
          .doc(roomModel.hashCompany)
          .collection(FirestoreConst.rooms())
          .add(roomModel.toMapFromFirestore());

      return (doc.id);
    } on FirebaseException catch (e, stacktrace) {
      throw RoomException(e.message ?? textError, stacktrace);
    }
  }

  @override
  Future<Unit> updateRoom({
    required String hashCompany,
    required String hashRoom,
    required Map<String, dynamic> room,
  }) async {
    const textError = 'Erro ao atualizar sala';
    try {
      await _db
          .collection(FirestoreConst.company())
          .doc(hashCompany)
          .collection(FirestoreConst.rooms())
          .doc(hashRoom)
          .update(room);
      return unit;
    } on FirebaseException catch (e, stacktrace) {
      throw RoomException(e.message ?? textError, stacktrace);
    }
  }
}
