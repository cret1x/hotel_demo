import 'package:hotel_demo/data/api/api_room.dart';
import 'package:hotel_demo/domain/model/room.dart';

class RoomMapper {
  static Room fromApi(ApiRoom room) {
    final peculiarities = room.peculiarities;
    peculiarities.sort((a, b) => a.length.compareTo(b.length));
    return Room(
      id: room.id,
      name: room.name,
      imageUrls: room.imageUrls,
      price: room.price,
      pricePer: room.pricePer,
      peculiarities: peculiarities,
    );
  }
}
