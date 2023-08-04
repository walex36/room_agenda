import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:room_agenda/src/features/rooms/rooms.dart';

class RoomProvider extends ChangeNotifier {
  final GetListRoomsUseCase _getListRoomsUseCase;
  final SetRoomUseCase _setRoomUseCase;
  final DeleteRoomUseCase _deleteRoomUseCase;

  late String hashCompany;
  List<Room> listRooms = [];
  bool showErroRoom = false;
  bool isLoadingRoom = false;

  RoomProvider({
    required GetListRoomsUseCase getListRoomsUseCase,
    required SetRoomUseCase setRoomUseCase,
    required DeleteRoomUseCase deleteRoomUseCase,
  })  : _getListRoomsUseCase = getListRoomsUseCase,
        _setRoomUseCase = setRoomUseCase,
        _deleteRoomUseCase = deleteRoomUseCase;

  void initRooms(String hashComp) async {
    hashCompany = hashComp;
    final roomsOrFailure = await _getListRoomsUseCase(
        ParamsGetListRooms(hashCompany: hashCompany));

    roomsOrFailure.fold(
      (rooms) {
        rooms.sort((a, b) => a.title.compareTo(b.title));
        listRooms.addAll(rooms);
      },
      (error) => null,
    );

    notifyListeners();
  }

  Future<void> createRoom({
    required String title,
    required String description,
  }) async {
    isLoadingRoom = true;
    notifyListeners();

    final room = Room(
      hashCompany: hashCompany,
      title: title,
      description: description,
    );

    final hashOrFailure = await _setRoomUseCase(ParamsSetRoom(room: room));

    hashOrFailure.fold(
      (hash) {
        isLoadingRoom = false;
        listRooms.add(room.copyWith(hash: hash));
        notifyListeners();
        Modular.to.pop();
      },
      (error) async {
        isLoadingRoom = false;
        showErroRoom = true;
        notifyListeners();

        await Future.delayed(const Duration(seconds: 5));

        showErroRoom = false;
      },
    );

    notifyListeners();
  }

  Future<void> removeRoom({
    required Room room,
  }) async {
    isLoadingRoom = true;
    notifyListeners();

    final deleteOrFailure = await _deleteRoomUseCase(ParamsDeleteRoom(
      hashCompany: hashCompany,
      hashRoom: room.hash,
    ));

    deleteOrFailure.fold(
      (success) {
        isLoadingRoom = false;
        listRooms.remove(room);
        notifyListeners();
        Modular.to.pop();
      },
      (error) async {
        isLoadingRoom = false;
        showErroRoom = true;
        notifyListeners();

        await Future.delayed(const Duration(seconds: 5));

        showErroRoom = false;
      },
    );
  }
}
