import 'package:flutter_modular/flutter_modular.dart';

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

  void createEvent({required EventDaily eventDaily}) async {
    isLoadingCreateEvent = true;
    notifyListeners();

    final result = await _fs.createEvent(
      hashCompany: room.hashCompany,
      hashRoom: room.hash,
      eventDaily: eventDaily,
    );

    isLoadingCreateEvent = false;
    if (result.$1) {
      listEvents.add(eventDaily);
      Modular.to.pop();
    } else {
      showErrorCreateEvent = true;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 5));
      showErrorCreateEvent = false;
    }

    notifyListeners();
  }

  void updateEvent({required EventDaily eventDaily}) async {
    isLoadingCreateEvent = true;
    notifyListeners();

    final result = await _fs.updateEvent(
      hashCompany: room.hashCompany,
      hashRoom: room.hash,
      eventDaily: eventDaily,
    );

    isLoadingCreateEvent = false;
    if (result) {
      listEvents[listEvents.indexWhere(
          (element) => element.hash == eventDaily.hash)] = eventDaily;
      Modular.to.pop();
    } else {
      showErrorCreateEvent = true;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 5));
      showErrorCreateEvent = false;
    }

    notifyListeners();
  }
}
