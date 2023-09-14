import 'package:hotel_demo/data/api/api_util.dart';
import 'package:hotel_demo/domain/model/hotel.dart';
import 'package:hotel_demo/domain/repository/hotel_repository.dart';

class HotelDataRepository extends HotelRepository {
  final ApiUtil _apiUtil;

  HotelDataRepository(this._apiUtil);

  @override
  Future<Hotel> getHotel() {
    return _apiUtil.getHotel();
  }
}