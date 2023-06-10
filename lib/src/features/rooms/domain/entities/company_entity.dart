import 'room_entity.dart';

class Company {
  final String hash;
  final String name;
  final String cnpj;
  final Map<String, bool> workingDays;
  final List<Room> rooms;

  Company({
    required this.hash,
    required this.name,
    required this.cnpj,
    required this.workingDays,
    required this.rooms,
  });
}
