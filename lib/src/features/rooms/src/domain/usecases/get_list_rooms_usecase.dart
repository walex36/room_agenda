import 'package:result_dart/result_dart.dart';
import 'package:room_agenda/src/core/core.dart';
import 'package:room_agenda/src/features/rooms/rooms.dart';

class GetListRoomsUseCase implements UseCase<List<Room>, ParamsGetListRooms> {
  final ImpRoomRepository repository;

  GetListRoomsUseCase({required this.repository});

  @override
  Future<Result<List<Room>, AppException>> call(ParamsGetListRooms params) {
    return repository.getListRooms(hashCompany: params.hashCompany);
  }
}

class ParamsGetListRooms {
  final String hashCompany;

  ParamsGetListRooms({required this.hashCompany});
}
