import 'package:hotel_demo/domain/model/booking_info.dart';

abstract class BookingInfoRepository {
  Future<BookingInfo> getBookingInfo();
}