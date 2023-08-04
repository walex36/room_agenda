import 'package:flutter_modular/flutter_modular.dart';
import 'package:room_agenda/src/features/rooms/rooms.dart';
import 'package:room_agenda/src/features/rooms/src/presetation/pages/room_info_page.dart';
import 'package:room_agenda/src/features/rooms/src/presetation/pages/rooms_page.dart';

class RoomsModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => RoomProvider(
              getListRoomsUseCase: i(),
              setRoomUseCase: i(),
              deleteRoomUseCase: i(),
            )),
        Bind((i) => RoomInfoProvider()),
        Bind((i) => GetListRoomsUseCase(repository: i())),
        Bind((i) => SetRoomUseCase(repository: i())),
        Bind((i) => DeleteRoomUseCase(repository: i())),
        Bind((i) => RoomRepository(dataSourceRemote: i())),
        Bind((i) => RoomFirestoreDataSource()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => RoomsPage(
            company: args.data['company'],
          ),
        ),
        ChildRoute(
          '/roomInfo',
          child: (context, args) => RoomInfoPage(
            room: args.data['room'],
          ),
        )
      ];
}
