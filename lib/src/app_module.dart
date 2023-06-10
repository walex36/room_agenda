import 'package:room_agenda/src/features/rooms/controller/room_provider.dart';
import 'package:room_agenda/src/features/rooms/data/datasource/room_firestore_datasource.dart';
import 'package:room_agenda/src/features/rooms/data/repositories/room_repository.dart';
import 'package:room_agenda/src/features/rooms/domain/usecases/get_list_rooms_usecase.dart';
import 'package:room_agenda/src/features/rooms/domain/usecases/set_room_usecase.dart';

import 'features/rooms/presetation/pages/room_info_page.dart';
import 'features/rooms/presetation/pages/rooms_page.dart';
import 'features/rooms/services/firestore_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        /// PROVIDERS
        Bind((i) => RoomProvider(
              getListRoomsUseCase: GetListRoomsUseCase(repository: i()),
              setRoomUseCase: SetRoomUseCase(repository: i()),
            )),

        /// Repositories
        Bind((i) => RoomRepository(dataSourceRemote: i())),

        /// DataSources
        Bind((i) => RoomFirestoreDataSource()),

        Bind((i) => FirestoreService()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const RoomsPage(),
        ),
        ChildRoute(
          '/roomInfo',
          child: (context, args) => RoomInfoPage(
            room: args.data['room'],
          ),
        )
      ];
}
