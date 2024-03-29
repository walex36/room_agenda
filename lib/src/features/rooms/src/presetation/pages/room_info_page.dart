import 'package:room_agenda/src/features/rooms/rooms.dart';
import '../../presetation/components/create_event_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:provider/provider.dart';

class RoomInfoPage extends StatefulWidget {
  final Room room;
  const RoomInfoPage({
    super.key,
    required this.room,
  });

  @override
  State<RoomInfoPage> createState() => _RoomInfoPageState();
}

class _RoomInfoPageState extends State<RoomInfoPage> {
  final roomInfoProvider = RoomInfoProvider();

  @override
  void initState() {
    roomInfoProvider.initRoomInfo(roomInit: widget.room);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RoomInfoProvider>(
      create: (context) => roomInfoProvider,
      child: Consumer<RoomInfoProvider>(builder: (context, provider, child) {
        bool isLoading = provider.isLoading;

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.room.title),
          ),
          floatingActionButton: Visibility(
            visible: !isLoading,
            child: FloatingActionButton.extended(
              onPressed: () async => await showDialog(
                context: context,
                builder: (context) => CreateEventDialog(
                  roomInfoProvider: provider,
                  eventEdit: null,
                ),
              ),
              label: const Text('Criar evento'),
            ),
          ),
          body: Visibility(
            visible: !isLoading,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: Calendar(
              isExpanded: true,
              datePickerType: DatePickerType.date,
              eventsList: provider.listEvents
                  .map((event) => NeatCleanCalendarEvent(
                        event.title,
                        description: event.description,
                        startTime: event.dateStart,
                        endTime: event.dateEnd,
                        onTap: () async => await showDialog(
                          context: context,
                          builder: (context) => CreateEventDialog(
                            roomInfoProvider: provider,
                            eventEdit: event,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        );
      }),
    );
  }
}
