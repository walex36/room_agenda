import 'package:room_agenda/src/features/rooms/domain/entities/event_daily_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<(bool, String)> createEvent({
    required String hashCompany,
    required String hashRoom,
    required EventDaily eventDaily,
  }) async {
    try {
      final doc = await _db
          .collection('company')
          .doc(hashCompany)
          .collection('rooms')
          .doc(hashRoom)
          .collection('events')
          .add(eventDaily.toMap());
      return (true, doc.id);
    } catch (e) {
      return (false, '');
    }
  }

  Future<bool> updateEvent({
    required String hashCompany,
    required String hashRoom,
    required EventDaily eventDaily,
  }) async {
    try {
      await _db
          .collection('company')
          .doc(hashCompany)
          .collection('rooms')
          .doc(hashRoom)
          .collection('events')
          .doc(eventDaily.hash)
          .update(eventDaily.toMap());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<EventDaily>> getListEvent({
    required String hashCompany,
    required String hashRoom,
  }) async {
    try {
      final doc = await _db
          .collection('company')
          .doc(hashCompany)
          .collection('rooms')
          .doc(hashRoom)
          .collection('events')
          .get();

      List<EventDaily> events = doc.docs
          .map(
            (e) => EventDaily.fromMapFirestore(map: e.data(), hash: e.id),
          )
          .toList();

      return events;
    } catch (e) {
      return [];
    }
  }
}
