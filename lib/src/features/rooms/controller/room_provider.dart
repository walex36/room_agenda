import '../models/room.dart';
import '../services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RoomProvider extends ChangeNotifier {
  final _fs = FirestoreService();

  late String hashCompany;
  List<Room> listRooms = [];
  bool showErroCreateRoom = false;
  bool isLoadingCreateRoom = false;

  void initRooms(String hashComp) async {
    hashCompany = hashComp;
    List<Room> rooms = await _fs.getListRooms(hashCompany);
    rooms.sort((a, b) => a.title.compareTo(b.title));
    listRooms.addAll(rooms);

    notifyListeners();
  }

  Future<void> createRoom({
    required String title,
    required String description,
  }) async {
    isLoadingCreateRoom = true;
    notifyListeners();

    final room = Room(
      hashCompany: hashCompany,
      title: title,
      description: description,
    );

    final isSaved = await _fs.createRoom(
      hashCompany: hashCompany,
      room: room,
    );
    isLoadingCreateRoom = false;

    if (isSaved.$1) {
      listRooms.add(room.copyWith(hash: isSaved.$2));
      notifyListeners();
      Modular.to.pop();
    } else {
      showErroCreateRoom = true;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 5));

      showErroCreateRoom = false;
      notifyListeners();
    }
  }
}
