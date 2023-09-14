class BookingInfo {
  final int id;
  final String hotelName;
  final String hotelAddress;
  final int rating;
  final String ratingName;
  final String departure;
  final String arrivalCountry;
  final DateTime tourStart;
  final DateTime tourEnd;
  final String tourStartString;
  final String tourEndString;
  final int nights;
  final String room;
  final String nutrition;
  final int price;
  final int fuelCharge;
  final int serviceCharge;

  BookingInfo({
    required this.id,
    required this.hotelName,
    required this.hotelAddress,
    required this.rating,
    required this.ratingName,
    required this.departure,
    required this.arrivalCountry,
    required this.tourStart,
    required this.tourEnd,
    required this.nights,
    required this.room,
    required this.nutrition,
    required this.price,
    required this.fuelCharge,
    required this.serviceCharge,
    required this.tourEndString,
    required this.tourStartString,
  });
}
