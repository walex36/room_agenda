// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:room_agenda/src/features/rooms/domain/entities/room_entity.dart';

class RoomModel extends Room {
  const RoomModel({
    required String hash,
    required String hashCompany,
    required String title,
    required String description,
  }) : super(
          hash: hash,
          hashCompany: hashCompany,
          title: title,
          description: description,
        );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hash': hash,
      'hashCompany': hashCompany,
      'title': title,
      'description': description,
      'ativo': true,
    };
  }

  Map<String, dynamic> toMapFromFirestore() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'ativo': true,
    };
  }

  Map<String, dynamic> toMapFirestoreUpdate({required RoomModel roomOld}) {
    final map = <String, dynamic>{};

    if (title != roomOld.title) {
      map.addAll({'title': title});
    }

    if (description != roomOld.description) {
      map.addAll({'description': description});
    }

    return map;
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      hash: map['hash'] as String,
      hashCompany: map['hashCompany'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  factory RoomModel.fromMapFirestore(
    Map<String, dynamic> map, {
    required String hash,
    required String hashCompany,
  }) {
    return RoomModel(
      hash: hash,
      hashCompany: hashCompany,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  Room toEntity() {
    return Room(
      hashCompany: hashCompany,
      hash: hash,
      title: title,
      description: description,
    );
  }

  factory RoomModel.fromEntity(Room room) {
    return RoomModel(
      hash: room.hash,
      hashCompany: room.hashCompany,
      title: room.title,
      description: room.description,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RoomModel(hash: $hash, hashCompany: $hashCompany, title: $title, description: $description)';
  }
}
