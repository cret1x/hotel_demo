import 'package:hotel_demo/data/api/api_util.dart';
import 'package:hotel_demo/domain/model/booking_info.dart';
import 'package:hotel_demo/domain/model/hotel.dart';
import 'package:hotel_demo/domain/repository/booking_info_repository.dart';


class BookingInfoDataRepository extends BookingInfoRepository {
  final ApiUtil _apiUtil;

  BookingInfoDataRepository(this._apiUtil);

  @override
  Future<BookingInfo> getBookingInfo() {
    return _apiUtil.getBookingInfo();
  }
}