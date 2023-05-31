import '../../controller/room_info_provider.dart';
import '../../models/room.dart';
import '../../presetation/components/create_event_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
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
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.room.title),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async => await showDialog(
              context: context,
              builder: (context) =>
                  CreateEventDialog(roomInfoProvider: provider),
            ),
            label: const Text('Criar evento'),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     final dt = DateTime(2023, 5, 31, 6);

          //     final event = EventDaily(
          //       hash: '',
          //       title: 'title',
          //       description: 'description',
          //       dateStart: dt,
          //       dateEnd: DateTime(dt.year, dt.month, dt.day, dt.hour + 1),
          //       type: TypeEventDaily.daily,
          //     );

          //     provider.createEvent(event);
          //   },
          // ),
          body: Calendar(
            eventsList: provider.listEvents
                .map((e) => NeatCleanCalendarEvent(
                      e.title,
                      description: e.description,
                      startTime: e.dateStart,
                      endTime: e.dateEnd,
                    ))
                .toList(),
          ),
        );

        // return Scaffold(
        //   appBar: AppBar(
        //     title: Text(widget.room.title),
        //   ),
        //   floatingActionButton: FloatingActionButton(
        //     onPressed: () {
        //       final dt = DateTime.now();

        //       final event = EventDaily(
        //         hash: '',
        //         title: 'title',
        //         description: 'description',
        //         start: const TimeOfDay(hour: 5, minute: 0),
        //         end: const TimeOfDay(hour: 6, minute: 0),
        //         dateStart: dt,
        //         dateEnd: DateTime(dt.year, dt.month, dt.day, dt.hour + 1),
        //         type: TypeEventDaily.daily,
        //       );

        //       provider.createEvent(event);
        //     },
        //   ),
        //   body: Column(
        //     children: [
        //       DatePicker(
        //         DateTime(2023),
        //         initialSelectedDate: DateTime.now(),
        //         selectionColor: Colors.black,
        //         selectedTextColor: Colors.white,
        //         onDateChange: (date) {
        //           // New date selected
        //         },
        //       ),
        //       const SizedBox(
        //         height: 10,
        //       ),
        //       Expanded(
        //         child: OverFlowCalendarDayView(
        //           events: provider.listEvents
        //               .map((e) => DayEvent<String>(
        //                     value: e.description,
        //                     start: e.start,
        //                     end: e.end,
        //                     name: e.title,
        //                   ))
        //               .toList(),
        //           dividerColor: Colors.black,
        //           startOfDay: const TimeOfDay(hour: 00, minute: 0),
        //           endOfDay: const TimeOfDay(hour: 23, minute: 0),
        //           timeGap: 60,
        //           renderRowAsListView: true,
        //           showCurrentTimeLine: true,
        //           showMoreOnRowButton: true,
        //           overflowItemBuilder: (context, constraints, event) {
        //             return Container(
        //               color: Colors.amber,
        //               constraints: constraints,
        //               child: Text(event.value),
        //             );
        //           },
        //         ),
        //       ),
        //     ],
        //   ),
        // );
      }),
    );
  }
}
