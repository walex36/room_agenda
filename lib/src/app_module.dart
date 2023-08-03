import 'package:room_agenda/src/core/src/const/router_const.dart';
import 'package:room_agenda/src/features/login/login.dart';
import 'package:room_agenda/src/features/rooms/controller/room_provider.dart';
import 'package:room_agenda/src/features/rooms/data/datasource/room_firestore_datasource.dart';
import 'package:room_agenda/src/features/rooms/data/repositories/room_repository.dart';
import 'package:room_agenda/src/features/rooms/domain/usecases/delete_room_usecase.dart';
import 'package:room_agenda/src/features/rooms/domain/usecases/get_list_rooms_usecase.dart';
import 'package:room_agenda/src/features/rooms/domain/usecases/set_room_usecase.dart';

import 'features/rooms/presetation/pages/room_info_page.dart';
import 'features/rooms/presetation/pages/rooms_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        /// PROVIDERS
        Bind((i) => RoomProvider(
              getListRoomsUseCase: i(),
              setRoomUseCase: i(),
              deleteRoomUseCase: i(),
            )),

        /// UseCases
        Bind((i) => GetListRoomsUseCase(repository: i())),
        Bind((i) => SetRoomUseCase(repository: i())),
        Bind((i) => DeleteRoomUseCase(repository: i())),

        /// Repositories
        Bind((i) => RoomRepository(dataSourceRemote: i())),

        /// DataSources
        Bind((i) => RoomFirestoreDataSource()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          RouterConst.login(),
          module: LoginModule(),
        ),
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
