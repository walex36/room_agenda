import '../../../../core/components/dialog_component.dart';
import '../../../../core/components/text_form_field_component.dart';
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
          title: const Text(
            "Criar sala",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _keyForm,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
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
                visible: provider.showErroCreateRoom,
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
              provider.isLoadingCreateRoom
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
