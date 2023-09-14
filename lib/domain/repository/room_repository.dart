import 'package:hotel_demo/domain/model/room.dart';

abstract class RoomRepository {
  Future<List<Room>> getRooms();
}