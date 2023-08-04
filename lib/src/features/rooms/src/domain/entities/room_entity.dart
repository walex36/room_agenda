import 'package:equatable/equatable.dart';

class Room extends Equatable {
  final String hash;
  final String hashCompany;
  final String title;
  final String description;

  const Room({
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

  @override
  List<Object?> get props => [
        hash,
        hashCompany,
        title,
        description,
      ];
}
