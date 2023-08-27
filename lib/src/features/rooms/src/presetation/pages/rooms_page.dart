import 'package:flutter_modular/flutter_modular.dart';
import 'package:room_agenda/src/features/company/company.dart';

import '../../presetation/components/create_room_dialog.dart';
import '../../presetation/components/room_card.dart';
import '../../controller/room_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomsPage extends StatefulWidget {
  final Company company;
  const RoomsPage({super.key, required this.company});

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  final roomProvider = Modular.get<RoomProvider>();

  @override
  void initState() {
    roomProvider.initRooms(widget.company.cnpj);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RoomProvider>(
      create: (context) => roomProvider,
      child: Consumer<RoomProvider>(
        builder: (context, provider, child) {
          bool isLoadingRoom = provider.isLoadingRoom;

          return Scaffold(
              appBar: AppBar(
                title: const Text('Listas de salas'),
              ),
              floatingActionButton: Visibility(
                visible: !isLoadingRoom,
                child: FloatingActionButton.extended(
                  onPressed: () async => await showDialog(
                    context: context,
                    builder: (context) =>
                        CreateRoomDialog(roomProvider: roomProvider),
                  ),
                  label: const Text('Criar Sala'),
                ),
              ),
              body: isLoadingRoom
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                      children: provider.listRooms
                          .map(
                            (room) => RoomCard(
                              room: room,
                              provider: provider,
                            ),
                          )
                          .toList(),
                    ));
        },
      ),
    );
  }
}
