
class ApiHotel {
  final int id;
  final String name;
  final String address;
  final int minimalPrice;
  final String priceForIt;
  final int rating;
  final String ratingName;
  final List<String> imageUrls;
  final String description;
  final List<String> peculiarities;

  ApiHotel({
    required this.id,
    required this.name,
    required this.address,
    required this.minimalPrice,
    required this.priceForIt,
    required this.rating,
    required this.ratingName,
    required this.imageUrls,
    required this.description,
    required this.peculiarities,
  });

  factory ApiHotel.fromApi(Map<String, dynamic> map) {
    int id = map['id'];
    String name = map['name'];
    String address = map['adress'];
    int minimalPrice = map['minimal_price'];
    String priceForIt = map['price_for_it'];
    int rating = map['rating'];
    String ratingName = map['rating_name'];
    List<String> imageUrls = (map['image_urls'] as Iterable).map((e) => e.toString()).toList();
    String description = map['about_the_hotel']['description'];
    List<String> peculiarities = (map['about_the_hotel']['peculiarities'] as Iterable).map((e) => e.toString()).toList();
    return ApiHotel(
      id: id,
      name: name,
      address: address,
      minimalPrice: minimalPrice,
      priceForIt: priceForIt,
      rating: rating,
      ratingName: ratingName,
      imageUrls: imageUrls,
      description: description,
      peculiarities: peculiarities,
    );
  }
}
