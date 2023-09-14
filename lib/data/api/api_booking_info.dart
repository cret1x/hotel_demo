class ApiBookingInfo {
  final int id;
  final String hotelName;
  final String hotelAddress;
  final int rating;
  final String ratingName;
  final String departure;
  final String arrivalCountry;
  final String tourStart;
  final String tourEnd;
  final int nights;
  final String room;
  final String nutrition;
  final int price;
  final int fuelCharge;
  final int servicePrice;

  ApiBookingInfo({
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
    required this.servicePrice,
  });

  factory ApiBookingInfo.fromApi(Map<String, dynamic> map) {
    int id = map['id'];
    String hotelName = map['hotel_name'];
    String hotelAddress = map['hotel_adress'];
    int rating = map['horating'];
    String ratingName = map['rating_name'];
    String departure = map['departure'];
    String arrivalCountry = map['arrival_country'];
    String tourStart = map['tour_date_start'];
    String tourEnd = map['tour_date_stop'];
    int nights = map['number_of_nights'];
    String room = map['room'];
    String nutrition = map['nutrition'];
    int price = map['tour_price'];
    int fuelCharge = map['fuel_charge'];
    int servicePrice = map['service_charge'];
    return ApiBookingInfo(
        id: id,
        hotelName: hotelName,
        hotelAddress: hotelAddress,
        rating: rating,
        ratingName: ratingName,
        departure: departure,
        arrivalCountry: arrivalCountry,
        tourStart: tourStart,
        tourEnd: tourEnd,
        nights: nights,
        room: room,
        nutrition: nutrition,
        price: price,
        fuelCharge: fuelCharge,
        servicePrice: servicePrice,
    );
  }
}
