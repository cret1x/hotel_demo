import 'package:hotel_demo/data/api/service/mocky_service.dart';
import 'package:hotel_demo/data/mapper/booking_info_mapper.dart';
import 'package:hotel_demo/data/mapper/hotel_mapper.dart';
import 'package:hotel_demo/data/mapper/room_mapper.dart';
import 'package:hotel_demo/domain/model/booking_info.dart';
import 'package:hotel_demo/domain/model/hotel.dart';
import 'package:hotel_demo/domain/model/room.dart';

class ApiUtil {
  final MockyService _mockyService;
  ApiUtil(this._mockyService);

  Future<Hotel> getHotel() async {
    final result = await _mockyService.getHotel();
    return HotelMapper.fromApi(result);
  }

  Future<List<Room>> getRooms() async {
    final result = await _mockyService.getRooms();
    return List.from(result.map((room) => RoomMapper.fromApi(room)));
  }

  Future<BookingInfo> getBookingInfo() async {
    final result = await _mockyService.getBookingInfo();
    return BookingInfoMapper.fromApi(result);
  }
}