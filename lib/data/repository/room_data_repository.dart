import 'package:hotel_demo/data/api/api_util.dart';
import 'package:hotel_demo/domain/model/room.dart';
import 'package:hotel_demo/domain/repository/room_repository.dart';


class RoomDataRepository extends RoomRepository {
  final ApiUtil _apiUtil;

  RoomDataRepository(this._apiUtil);

  @override
  Future<List<Room>> getRooms() {
    return _apiUtil.getRooms();
  }
}