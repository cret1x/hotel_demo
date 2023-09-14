import 'package:hotel_demo/domain/model/hotel.dart';

abstract class HotelRepository {
  Future<Hotel> getHotel();
}