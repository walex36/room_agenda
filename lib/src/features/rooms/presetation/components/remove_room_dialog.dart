import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:room_agenda/src/core/components/dialog_component.dart';
import 'package:room_agenda/src/features/rooms/controller/room_provider.dart';
import 'package:room_agenda/src/features/rooms/domain/entities/room_entity.dart';

class RemoveRoomDialog extends StatelessWidget {
  final Room room;
  final RoomProvider provider;
  const RemoveRoomDialog({
    super.key,
    required this.room,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RoomProvider>.value(
      value: provider,
      child: Consumer<RoomProvider>(builder: (context, provider, child) {
        return DialogComponent(
          title: 'Remover Sala',
          body: Text(
            'Depois de remover ${room.title} não sera possivel '
            'mostrar novamente! Confirme para remover.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
          ),
          footer: Column(
            children: [
              Visibility(
                visible: provider.showErroRoom,
                child: Column(
                  children: [
                    Text(
                      'Erro ao remover sala',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red.shade400,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    )
                  ],
                ),
              ),
              provider.isLoadingRoom
                  ? const Center(child: CircularProgressIndicator())
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () => Modular.to.pop(),
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () => provider.removeRoom(
                            room: room,
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.red.shade400,
                          )),
                          child: const Text(
                            'Confirmar',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
            ],
          ),
        );
      }),
    );
  }
}
