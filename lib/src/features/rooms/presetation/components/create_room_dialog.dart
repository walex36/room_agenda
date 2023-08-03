import 'package:room_agenda/src/core/core.dart';

import '../../controller/room_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateRoomDialog extends StatelessWidget {
  final RoomProvider roomProvider;
  CreateRoomDialog({
    super.key,
    required this.roomProvider,
  });

  final _keyForm = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();

  final _descriptionTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RoomProvider>.value(
      value: roomProvider,
      child: Consumer<RoomProvider>(builder: (context, provider, child) {
        return DialogComponent(
          title: "Criar sala",
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _keyForm,
                child: Column(
                  children: [
                    TextFormFieldComponent(
                      labelInput: 'Nome da sala',
                      controller: _nameTextController,
                      maxLength: 50,
                      validator: (value) {
                        if (value == '') {
                          return 'Adicione um nome para a sala!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormFieldComponent(
                      labelInput: 'Descrição da sala',
                      controller: _descriptionTextController,
                      maxLength: 250,
                    ),
                  ],
                ),
              )),
          footer: Column(
            children: [
              Visibility(
                visible: provider.showErroRoom,
                child: Column(
                  children: [
                    Text(
                      'Erro ao criar sala',
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Cancelar",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            )),
                        TextButton(
                            onPressed: () {
                              if (_keyForm.currentState!.validate()) {
                                roomProvider.createRoom(
                                  title: _nameTextController.text,
                                  description: _descriptionTextController.text,
                                );
                              }
                            },
                            child: Text(
                              "Confirmar",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    )
            ],
          ),
        );
      }),
    );
  }
}
