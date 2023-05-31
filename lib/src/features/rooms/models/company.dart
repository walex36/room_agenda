import 'room.dart';

class Company {
  final String hash;
  final String name;
  final String cnpj;
  final List<Room> rooms;

  Company({
    required this.hash,
    required this.name,
    required this.cnpj,
    required this.rooms,
  });
}
