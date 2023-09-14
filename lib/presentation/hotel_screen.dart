import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_demo/domain/model/hotel.dart';
import 'package:hotel_demo/domain/state/hotel_screen_state.dart';
import 'package:hotel_demo/presentation/image_slider.dart';
import 'package:hotel_demo/presentation/rating_widget.dart';
import 'package:hotel_demo/presentation/rooms_screen.dart';

class HotelScreen extends ConsumerStatefulWidget {
  const HotelScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HotelScreenWidgetState();
}

class _HotelScreenWidgetState extends ConsumerState<HotelScreen> {
  final _hotelFeatures = [
    {'assets/icons/emoji_happy.svg', "Удобвства"},
    {'assets/icons/tick_square.svg', "Что включено"},
    {'assets/icons/close_square.svg', "Что не включено"},
  ];

  @override
  Widget build(BuildContext context) {
    final hotelFuture = ref.watch(hotelProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 246, 249),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text("Отель"),
      ),
      body: hotelFuture.when(
        data: (hotel) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _getHotelCard(hotel),
                _getHotelInfoCard(hotel),
              ],
            ),
          );
        },
        error: (obj, trace) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Произошла ошибка при загрузке"),
              ],
            ),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: hotelFuture.hasValue ? () {
               context.push(Uri(path: '/rooms', queryParameters: {'hotelName' : hotelFuture.value!.name}).toString());
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "К выбору номера",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getHotelCard(Hotel hotel) {
    hotel.imageUrls.forEach((url) {
      precacheImage(NetworkImage(url), context);
    });
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageSlider(
                items: List.from(hotel.imageUrls.map((url) => Image.network(
                      url,
                      fit: BoxFit.fill,
                    ))),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RatingWidget(
                    rating: hotel.rating,
                    ratingName: hotel.ratingName,
                  )),
              Text(
                hotel.name,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    hotel.address,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 13, 114, 255)),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "от ${hotel.minimalPrice} ₽",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 5),
                    child: Text(
                      hotel.priceForIt,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 130, 135, 150),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getHotelInfoCard(Hotel hotel) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Об отеле",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Wrap(
                  spacing: 4,
                  children: List.from(hotel.peculiarities.map((e) => Chip(
                        label: Text(
                          e,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 130, 135, 150)),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 251, 251, 252),
                        side: BorderSide.none,
                      ))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  hotel.description,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  child: Card(
                    color: const Color.fromARGB(255, 251, 251, 252),
                    surfaceTintColor: const Color.fromARGB(255, 251, 251, 252),
                    child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const Divider(
                        height: 4,
                        indent: 55,
                        endIndent: 25,
                      ),
                      itemCount: 3,
                      itemBuilder: (context, index) => ListTile(
                        leading: SvgPicture.asset(
                            _hotelFeatures.elementAt(index).first),
                        title: Text(
                          _hotelFeatures.elementAt(index).last,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 44, 48, 53)),
                        ),
                        subtitle: const Text(
                          "Самое необходимое",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 130, 135, 150),
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
