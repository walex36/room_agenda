import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_agenda/src/features/rooms/enums/type_event_daily_enum.dart';
import 'package:room_agenda/src/features/rooms/models/eventDaily.dart';
import '../../../../core/components/text_form_field_component.dart';
import '../../../../core/components/dialog_component.dart';
import '../../controller/room_info_provider.dart';

class CreateEventDialog extends StatelessWidget {
  final RoomInfoProvider roomInfoProvider;
  CreateEventDialog({
    super.key,
    required this.roomInfoProvider,
  });

  final _keyForm = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  DateTime _dateStart = DateTime.now();
  DateTime _dateEnd = DateTime.now();
  TypeEventDaily _typeEvent = TypeEventDaily.notRepeat;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RoomInfoProvider>.value(
      value: roomInfoProvider,
      child: Consumer<RoomInfoProvider>(builder: (context, provider, child) {
        return DialogComponent(
          title: const Text(
            "Criar evento",
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
                      labelInput: 'Titulo',
                      controller: _nameTextController,
                      maxLength: 50,
                      validator: (value) {
                        if (value == '') {
                          return 'Adicione um titulo para o evento!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormFieldComponent(
                      labelInput: 'Descrição',
                      controller: _descriptionTextController,
                      maxLength: 250,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Inicio',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade600),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    '2023/05/02',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  Text(
                                    '15:00',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Fim',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade600),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    '2023/05/02',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  Text(
                                    '15:00',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Radio<TypeEventDaily>(
                              value: TypeEventDaily.notRepeat,
                              groupValue: _typeEvent,
                              onChanged: (value) => _typeEvent = value!,
                            ),
                            Text(
                              'Não repetir',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Radio<TypeEventDaily>(
                              value: TypeEventDaily.daily,
                              groupValue: _typeEvent,
                              onChanged: (value) => _typeEvent = value!,
                            ),
                            Text(
                              'Diaria',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Radio<TypeEventDaily>(
                              value: TypeEventDaily.weekly,
                              groupValue: _typeEvent,
                              onChanged: (value) => _typeEvent = value!,
                            ),
                            Text(
                              'Semanal',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )),
          footer: Column(
            children: [
              Visibility(
                visible: provider.showErrorCreateEvent,
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
              provider.isLoadingCreateEvent
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
                                provider.createEvent(
                                    eventDaily: EventDaily(
                                  hash: '',
                                  title: _nameTextController.text,
                                  description: _descriptionTextController.text,
                                  dateStart: _dateStart,
                                  dateEnd: _dateEnd,
                                  type: _typeEvent,
                                ));
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
