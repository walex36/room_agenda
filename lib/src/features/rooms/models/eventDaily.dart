// ignore_for_file: file_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../enums/type_event_daily_enum.dart';

class EventDaily {
  final String hash;
  final String title;
  final String description;
  final DateTime dateStart;
  final DateTime dateEnd;
  final TypeEventDaily type;
  EventDaily({
    required this.hash,
    required this.title,
    required this.description,
    required this.dateStart,
    required this.dateEnd,
    required this.type,
  });

  EventDaily copyWith({
    String? hash,
    String? title,
    String? description,
    DateTime? dateStart,
    DateTime? dateEnd,
    TypeEventDaily? type,
  }) {
    return EventDaily(
      hash: hash ?? this.hash,
      title: title ?? this.title,
      description: description ?? this.description,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'dateStart': dateStart.millisecondsSinceEpoch,
      'dateEnd': dateEnd.millisecondsSinceEpoch,
      'type': type.name,
    };
  }

  factory EventDaily.fromMap(Map<String, dynamic> map) {
    return EventDaily(
      hash: map['hash'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      dateStart: DateTime.fromMillisecondsSinceEpoch(
          (map['dateStart'] as Timestamp).millisecondsSinceEpoch),
      dateEnd: DateTime.fromMillisecondsSinceEpoch(
          (map['dateEnd'] as Timestamp).millisecondsSinceEpoch),
      type: (map['type'] as String).typeEventDailyFromMap(),
    );
  }

  factory EventDaily.fromMapFirestore({
    required Map<String, dynamic> map,
    required String hash,
  }) {
    return EventDaily(
      hash: hash,
      title: map['title'] as String,
      description: map['description'] as String,
      dateStart: DateTime.fromMillisecondsSinceEpoch(map['dateStart']),
      dateEnd: DateTime.fromMillisecondsSinceEpoch(map['dateEnd']),
      type: (map['type'] as String).typeEventDailyFromMap(),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventDaily.fromJson(String source) =>
      EventDaily.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EventDaily(hash: $hash, title: $title, description: $description, dateStart: $dateStart, dateEnd: $dateEnd, type: $type)';
  }

  @override
  bool operator ==(covariant EventDaily other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.dateStart == dateStart &&
        other.dateEnd == dateEnd &&
        other.type == type;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        dateStart.hashCode ^
        dateEnd.hashCode ^
        type.hashCode;
  }
}
