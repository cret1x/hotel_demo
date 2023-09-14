import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_demo/domain/model/room.dart';
import 'package:hotel_demo/domain/state/rooms_screen_state.dart';
import 'package:hotel_demo/presentation/booking_screen.dart';
import 'package:hotel_demo/presentation/image_slider.dart';

class RoomsScreen extends ConsumerStatefulWidget {
  final String hotelName;

  const RoomsScreen({super.key, required this.hotelName});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends ConsumerState<RoomsScreen> {
  @override
  Widget build(BuildContext context) {
    final roomsFuture = ref.watch(roomsProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 246, 249),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(widget.hotelName),
      ),
      body: roomsFuture.when(
        data: (rooms) {
          return ListView(
            children: List.from(rooms.map((room) => _getRoomCard(room))),
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
    );
  }

  Widget _getRoomCard(Room room) {
    room.imageUrls.forEach((url) {
      precacheImage(NetworkImage(url), context, onError: (object, trace) {});
    });
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
              ImageSlider(
                items: List.from(
                  room.imageUrls.map(
                    (url) => Image.network(
                      url,
                      fit: BoxFit.fill,
                      errorBuilder: (context, obj, trace) => const Center(
                          child: Text("Не удалось загрузить изображение")),
                    ),
                  ),
                ),
                height: 257,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  room.name,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
              Wrap(
                spacing: 4,
                children: List.from(room.peculiarities.map((e) => Chip(
                      label: Text(
                        e,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 130, 135, 150)),
                      ),
                      backgroundColor: const Color.fromARGB(255, 251, 251, 252),
                      side: BorderSide.none,
                    ))),
              ),
              TextButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 231, 241, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                label: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromARGB(255, 13, 114, 255),
                ),
                icon: const Text(
                  "Подробнее о номере",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 13, 114, 255)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${room.price} ₽",
                      style:
                          const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 5),
                      child: Text(
                        room.pricePer,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 130, 135, 150),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    context.push('/booking');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "Выбрать номер",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
