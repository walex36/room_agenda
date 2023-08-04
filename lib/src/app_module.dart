import 'package:room_agenda/src/core/src/const/router_const.dart';
import 'package:room_agenda/src/features/company/company.dart';
import 'package:room_agenda/src/features/login/login.dart';
import 'package:room_agenda/src/features/rooms/rooms.dart';
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
        ModuleRoute(
          RouterConst.company(),
          module: CompanyModule(),
        ),
        ModuleRoute(
          RouterConst.rooms(),
          module: RoomsModule(),
        ),
      ];
}
