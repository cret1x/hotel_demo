import 'package:hotel_demo/data/repository/booking_info_data_repository.dart';
import 'package:hotel_demo/data/repository/hotel_data_repository.dart';
import 'package:hotel_demo/data/repository/room_data_repository.dart';
import 'package:hotel_demo/domain/repository/booking_info_repository.dart';
import 'package:hotel_demo/domain/repository/hotel_repository.dart';
import 'package:hotel_demo/domain/repository/room_repository.dart';
import 'package:hotel_demo/internal/dependencies/api_module.dart';

class RepositoryModule {
  static HotelRepository? _hotelRepository;
  static RoomRepository? _roomRepository;
  static BookingInfoRepository? _bookingInfoRepository;

  static HotelRepository hotelRepository() {
    _hotelRepository ??= HotelDataRepository(ApiModule.apiUtil());
    return _hotelRepository!;
  }

  static RoomRepository roomRepository() {
    _roomRepository ??= RoomDataRepository(ApiModule.apiUtil());
    return _roomRepository!;
  }

  static BookingInfoRepository bookingInfoRepository() {
    _bookingInfoRepository ??= BookingInfoDataRepository(ApiModule.apiUtil());
    return _bookingInfoRepository!;
  }
}