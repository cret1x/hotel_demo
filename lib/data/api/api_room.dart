class ApiRoom {
  final int id;
  final String name;
  final int price;
  final String pricePer;
  final List<String> peculiarities;
  final List<String> imageUrls;

  ApiRoom({
    required this.id,
    required this.name,
    required this.price,
    required this.pricePer,
    required this.imageUrls,
    required this.peculiarities,
  });

  factory ApiRoom.fromApi(Map<String, dynamic> map) {
    int id = map['id'];
    String name = map['name'];
    int price = map['price'];
    String pricePer = map['price_per'];
    List<String> imageUrls =
        (map['image_urls'] as Iterable).map((e) => e.toString()).toList();
    List<String> peculiarities =
        (map['peculiarities'] as Iterable).map((e) => e.toString()).toList();
    return ApiRoom(
      id: id,
      name: name,
      price: price,
      pricePer: pricePer,
      imageUrls: imageUrls,
      peculiarities: peculiarities,
    );
  }
}
