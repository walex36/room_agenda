import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:room_agenda/src/features/rooms/rooms.dart';

import 'remove_room_dialog.dart';

class RoomCard extends StatelessWidget {
  final Room room;
  final RoomProvider provider;
  const RoomCard({
    super.key,
    required this.room,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Modular.to.pushNamed(
        'roomInfo',
        arguments: {
          'room': room,
        },
      ),
      onLongPress: () async => await showDialog(
        context: context,
        builder: (context) => RemoveRoomDialog(
          room: room,
          provider: provider,
        ),
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
