import '../../../rooms/models/room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RoomCard extends StatelessWidget {
  final Room room;
  const RoomCard({
    super.key,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Modular.to.pushNamed(
        '/roomInfo',
        arguments: {
          'room': room,
        },
      ),
      title: Text(
        room.title,
      ),
      subtitle: Text(
        room.description,
      ),
    );
  }
}
