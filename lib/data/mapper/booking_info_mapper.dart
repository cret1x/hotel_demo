import 'package:hotel_demo/data/api/api_booking_info.dart';
import 'package:hotel_demo/domain/model/booking_info.dart';
import 'package:intl/intl.dart';

class BookingInfoMapper {
  static BookingInfo fromApi(ApiBookingInfo bookingInfo) {
    final dateFormat = DateFormat("dd.MM.yyyy");
    DateTime s = dateFormat.parse(bookingInfo.tourStart);
    DateTime e = dateFormat.parse(bookingInfo.tourEnd);
    return BookingInfo(
      id: bookingInfo.id,
      hotelName: bookingInfo.hotelName,
      hotelAddress: bookingInfo.hotelAddress,
      rating: bookingInfo.rating,
      ratingName: bookingInfo.ratingName,
      departure: bookingInfo.departure,
      arrivalCountry: bookingInfo.arrivalCountry,
      tourStart: s,
      tourEnd: e,
      tourStartString: bookingInfo.tourStart,
      tourEndString: bookingInfo.tourEnd,
      nights: bookingInfo.nights,
      room: bookingInfo.room,
      nutrition: bookingInfo.nutrition,
      price: bookingInfo.price,
      fuelCharge: bookingInfo.fuelCharge,
      serviceCharge: bookingInfo.servicePrice,
    );
  }
}
