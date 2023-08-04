import 'package:flutter_modular/flutter_modular.dart';
import 'package:room_agenda/src/features/rooms/rooms.dart';

import '../services/firestore_service.dart';
import 'package:flutter/material.dart';

class RoomInfoProvider extends ChangeNotifier {
  final _fs = FirestoreService();

  late Room room;
  late final List<EventDaily> listEventsFs;
  List<EventDaily> listEvents = [];

  bool showErrorCreateEvent = false;
  bool isLoadingCreateEvent = false;

  Future<void> initRoomInfo({required Room roomInit}) async {
    room = roomInit;
    List<EventDaily> events = await _fs.getListEvent(
      hashCompany: room.hashCompany,
      hashRoom: room.hash,
    );
    listEventsFs = events;

    await generateListEvents();
    notifyListeners();
  }

  Future<void> generateListEvents() async {
    final List<EventDaily> listReturn = [];
    for (var h = 0; h < listEventsFs.length; h++) {
      final event = listEventsFs[h];

      if (event.type == TypeEventDaily.notRepeat) {
        listReturn.add(event);
      }
      if (event.type == TypeEventDaily.daily) {
        final int range = event.dateEnd.difference(event.dateStart).inDays;
        for (var i = 0; i <= range; i++) {
          listReturn.add(event.copyWith(
            dateStart: event.dateStart.copyWith(
              day: event.dateStart.day + i,
            ),
          ));
        }
      }
      if (event.type == TypeEventDaily.weekly) {
        final int weeklyRange =
            (event.dateEnd.difference(event.dateStart).inDays / 7).truncate();

        for (var i = 0; i <= weeklyRange; i++) {
          listReturn.add(event.copyWith(
            dateStart: event.dateStart.copyWith(
              day: event.dateStart.day + (i * 7),
            ),
          ));
        }
      }
    }
    listEvents = listReturn;
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
      listEventsFs.add(eventDaily);
      Modular.to.pop();
    } else {
      showErrorCreateEvent = true;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 5));
      showErrorCreateEvent = false;
    }

    await generateListEvents();
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
      listEventsFs[listEventsFs.indexWhere(
          (element) => element.hash == eventDaily.hash)] = eventDaily;
      Modular.to.pop();
    } else {
      showErrorCreateEvent = true;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 5));
      showErrorCreateEvent = false;
    }

    await generateListEvents();
    notifyListeners();
  }
}
