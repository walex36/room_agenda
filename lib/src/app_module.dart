import 'features/rooms/presetation/pages/room_info_page.dart';
import 'features/rooms/presetation/pages/rooms_page.dart';
import 'features/rooms/services/firestore_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [Bind((i) => FirestoreService())];

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
