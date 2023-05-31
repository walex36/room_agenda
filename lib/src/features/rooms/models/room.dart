// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Room {
  final String hash;
  final String hashCompany;
  final String title;
  final String description;

  Room({
    this.hash = '',
    required this.hashCompany,
    required this.title,
    required this.description,
  });

  Room copyWith({
    String? hash,
    String? hashCompany,
    String? title,
    String? description,
  }) {
    return Room(
      hash: hash ?? this.hash,
      hashCompany: hashCompany ?? this.hashCompany,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hashCompany': hashCompany,
      'title': title,
      'description': description,
    };
  }

  factory Room.fromMapFirestore(Map<String, dynamic> map, String hash) {
    return Room(
      hash: hash,
      hashCompany: map['hashCompany'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      hashCompany: map['hashCompany'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Room.fromJson(String source) =>
      Room.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Room(hash: $hash, hashCompany: $hashCompany, title: $title, description: $description)';

  @override
  bool operator ==(covariant Room other) {
    if (identical(this, other)) return true;

    return other.title == title && other.description == description;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode;
}
