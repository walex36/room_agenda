import '../models/eventDaily.dart';
import '../models/room.dart';
import '../services/firestore_service.dart';
import 'package:flutter/material.dart';

class RoomInfoProvider extends ChangeNotifier {
  final _fs = FirestoreService();

  late Room room;
  List<EventDaily> listEvents = [];

  bool showErrorCreateEvent = false;
  bool isLoadingCreateEvent = false;

  Future<void> initRoomInfo({required Room roomInit}) async {
    room = roomInit;
    List<EventDaily> events = await _fs.getListEvent(
      hashCompany: room.hashCompany,
      hashRoom: room.hash,
    );
    listEvents = events;

    notifyListeners();
  }

  void getListEventsByDay() {}

  void createEvent({required EventDaily eventDaily}) async {
    isLoadingCreateEvent = true;
    notifyListeners();

    final result = await _fs.createEvent(
      hashCompany: room.hashCompany,
      hashRoom: room.hash,
      eventDaily: eventDaily,
    );

    if (result.$1) {
      listEvents.add(eventDaily);
    } else {
      showErrorCreateEvent = true;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 5));
      showErrorCreateEvent = false;
    }

    notifyListeners();
  }
}
