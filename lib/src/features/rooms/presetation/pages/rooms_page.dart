import '../../presetation/components/create_room_dialog.dart';
import '../../presetation/components/room_card.dart';
import '../../controller/room_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({super.key});

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  final roomProvider = RoomProvider();

  @override
  void initState() {
    roomProvider.initRooms("OC2xlLdrnsPd7nCF6ScL");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listas de salas'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async => await showDialog(
          context: context,
          builder: (context) => CreateRoomDialog(roomProvider: roomProvider),
        ),
        label: const Text('Criar Sala'),
      ),
      body: ChangeNotifierProvider<RoomProvider>(
        create: (context) => roomProvider,
        child: Consumer<RoomProvider>(builder: (context, provider, child) {
          return ListView(
            children: provider.listRooms
                .map((room) => RoomCard(
                      room: room,
                    ))
                .toList(),
          );
        }),
      ),
    );
  }
}
