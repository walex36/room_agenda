import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_agenda/src/core/extension/date_time_extension.dart';
import 'package:room_agenda/src/core/extension/time_of_day_extension.dart';
import '../../enums/type_event_daily_enum.dart';
import '../../models/eventDaily.dart';
import '../../../../core/components/text_form_field_component.dart';
import '../../../../core/components/dialog_component.dart';
import '../../controller/room_info_provider.dart';

class CreateEventDialog extends StatefulWidget {
  final RoomInfoProvider roomInfoProvider;
  final EventDaily? eventEdit;

  const CreateEventDialog({
    super.key,
    required this.roomInfoProvider,
    required this.eventEdit,
  });

  @override
  State<CreateEventDialog> createState() => _CreateEventDialogState();
}

class _CreateEventDialogState extends State<CreateEventDialog> {
  final _keyForm = GlobalKey<FormState>();
  late TextEditingController _nameTextController;
  late TextEditingController _descriptionTextController;

  late DateTime _dateStart;
  late DateTime _dateEnd;

  late TypeEventDaily _typeEvent;

  late bool editEvent;

  @override
  void initState() {
    editEvent = widget.eventEdit != null;
    _nameTextController =
        TextEditingController(text: editEvent ? widget.eventEdit!.title : '');
    _descriptionTextController = TextEditingController(
        text: editEvent ? widget.eventEdit!.description : '');

    _dateStart = editEvent ? widget.eventEdit!.dateStart : DateTime.now();
    _dateEnd = editEvent ? widget.eventEdit!.dateEnd : DateTime.now();

    _typeEvent = editEvent ? widget.eventEdit!.type : TypeEventDaily.notRepeat;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RoomInfoProvider>.value(
      value: widget.roomInfoProvider,
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
                child: Column(
                  children: [
                    TextFormFieldComponent(
                      labelInput: 'Titulo',
                      controller: _nameTextController,
                      maxLength: 50,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
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
                    Text(
                      'Horário',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            TimeOfDay? timeStart = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(_dateStart),
                            );

                            if (timeStart != null) {
                              if (timeStart
                                  .isAfter(TimeOfDay.fromDateTime(_dateEnd))) {
                                setState(() {
                                  _dateStart = DateTime(
                                    _dateStart.year,
                                    _dateStart.month,
                                    _dateStart.day,
                                    TimeOfDay.fromDateTime(_dateEnd).hour,
                                    TimeOfDay.fromDateTime(_dateEnd).minute,
                                  );
                                });
                              } else {
                                setState(() {
                                  _dateStart = DateTime(
                                    _dateStart.year,
                                    _dateStart.month,
                                    _dateStart.day,
                                    timeStart.hour,
                                    timeStart.minute,
                                  );
                                });
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade600),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _dateStart.hourMinutes(),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Até',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            TimeOfDay? timeEnd = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(_dateEnd),
                            );

                            if (timeEnd != null) {
                              if (timeEnd.isBefore(
                                  TimeOfDay.fromDateTime(_dateStart))) {
                                setState(() {
                                  _dateEnd = DateTime(
                                    _dateEnd.year,
                                    _dateEnd.month,
                                    _dateEnd.day,
                                    TimeOfDay.fromDateTime(_dateStart).hour,
                                    TimeOfDay.fromDateTime(_dateStart).minute,
                                  );
                                });
                              } else {
                                setState(() {
                                  _dateEnd = DateTime(
                                    _dateEnd.year,
                                    _dateEnd.month,
                                    _dateEnd.day,
                                    timeEnd.hour,
                                    timeEnd.minute,
                                  );
                                });
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade600),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _dateEnd.hourMinutes(),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Data',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            DateTime? dateStart = await showDatePicker(
                              context: context,
                              initialDate: _dateStart,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2030),
                            );

                            if (dateStart != null) {
                              if (_typeEvent == TypeEventDaily.notRepeat) {
                                setState(() {
                                  _dateStart = DateTime(
                                    dateStart.year,
                                    dateStart.month,
                                    dateStart.day,
                                    _dateStart.hour,
                                    _dateStart.minute,
                                  );
                                  _dateEnd = DateTime(
                                    dateStart.year,
                                    dateStart.month,
                                    dateStart.day,
                                    _dateEnd.hour,
                                    _dateEnd.minute,
                                  );
                                });
                              } else if (dateStart.isAfter(_dateEnd)) {
                                setState(() {
                                  _dateStart = DateTime(
                                    _dateEnd.year,
                                    _dateEnd.month,
                                    _dateEnd.day,
                                    _dateStart.hour,
                                    _dateStart.minute,
                                  );
                                });
                              } else {
                                setState(() {
                                  _dateStart = DateTime(
                                    dateStart.year,
                                    dateStart.month,
                                    dateStart.day,
                                    _dateStart.hour,
                                    _dateStart.minute,
                                  );
                                });
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade600),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _dateStart.dayMonthYear(),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width:
                              _typeEvent != TypeEventDaily.notRepeat ? 10 : 0,
                        ),
                        Visibility(
                          visible: _typeEvent != TypeEventDaily.notRepeat,
                          child: Text(
                            'Até',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        SizedBox(
                          width:
                              _typeEvent != TypeEventDaily.notRepeat ? 10 : 0,
                        ),
                        Visibility(
                          visible: _typeEvent != TypeEventDaily.notRepeat,
                          child: InkWell(
                            onTap: () async {
                              DateTime? dateEnd = await showDatePicker(
                                context: context,
                                initialDate: _dateEnd,
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030),
                              );

                              if (dateEnd != null) {
                                if (dateEnd.isBefore(_dateStart)) {
                                  setState(() {
                                    _dateEnd = DateTime(
                                      _dateStart.year,
                                      _dateStart.month,
                                      _dateStart.day,
                                      _dateEnd.hour,
                                      _dateEnd.minute,
                                    );
                                  });
                                } else {
                                  setState(() {
                                    _dateEnd = DateTime(
                                      dateEnd.year,
                                      dateEnd.month,
                                      dateEnd.day,
                                      _dateEnd.hour,
                                      _dateEnd.minute,
                                    );
                                  });
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade600),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                _dateEnd.dayMonthYear(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
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
                              onChanged: (value) {
                                setState(() {
                                  _typeEvent = value!;
                                });
                              },
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
                              onChanged: (value) {
                                setState(() {
                                  _typeEvent = value!;
                                  _dateEnd = DateTime(
                                    _dateStart.year,
                                    _dateStart.month,
                                    _dateStart.day,
                                    _dateEnd.hour,
                                    _dateEnd.minute,
                                  );
                                });
                              },
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
                              onChanged: (value) {
                                setState(() {
                                  _typeEvent = value!;
                                });
                              },
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
                      editEvent
                          ? 'Erro ao atualizar evento'
                          : 'Erro ao criar evento',
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
                                if (editEvent) {
                                  provider.updateEvent(
                                      eventDaily: EventDaily(
                                    hash: widget.eventEdit!.hash,
                                    title: _nameTextController.text,
                                    description:
                                        _descriptionTextController.text,
                                    dateStart: _dateStart,
                                    dateEnd: _dateEnd,
                                    type: _typeEvent,
                                  ));
                                } else {
                                  provider.createEvent(
                                      eventDaily: EventDaily(
                                    hash: '',
                                    title: _nameTextController.text,
                                    description:
                                        _descriptionTextController.text,
                                    dateStart: _dateStart,
                                    dateEnd: _dateEnd,
                                    type: _typeEvent,
                                  ));
                                }
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
