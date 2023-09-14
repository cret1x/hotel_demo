import 'package:hotel_demo/data/api/api_hotel.dart';
import 'package:hotel_demo/domain/model/hotel.dart';

class HotelMapper {
  static Hotel fromApi(ApiHotel hotel) {
    final peculiarities = hotel.peculiarities;
    peculiarities.sort((a, b) => a.length.compareTo(b.length));
    return Hotel(
      id: hotel.id,
      name: hotel.name,
      address: hotel.address,
      minimalPrice: hotel.minimalPrice,
      priceForIt: hotel.priceForIt,
      rating: hotel.rating,
      ratingName: hotel.ratingName,
      imageUrls: hotel.imageUrls,
      description: hotel.description,
      peculiarities: peculiarities,
    );
  }
}
