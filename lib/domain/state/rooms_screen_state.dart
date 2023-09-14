import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_demo/domain/model/room.dart';
import 'package:hotel_demo/domain/repository/room_repository.dart';
import 'package:hotel_demo/internal/dependencies/repository_module.dart';

final roomsProvider = FutureProvider<List<Room>>((ref) {
  final RoomRepository roomRepository = RepositoryModule.roomRepository();
  return roomRepository.getRooms();
});