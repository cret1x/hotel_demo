import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_demo/presentation/booking_screen.dart';
import 'package:hotel_demo/presentation/hotel_screen.dart';
import 'package:hotel_demo/presentation/payment_screen.dart';
import 'package:hotel_demo/presentation/rooms_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}


final _router = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const HotelScreen()),
  GoRoute(path: '/rooms', builder: (context, state) => RoomsScreen(hotelName: state.uri.queryParameters['hotelName']!)),
  GoRoute(path: '/booking', builder: (context, state) => const BookingScreen()),
  GoRoute(path: '/payment', builder: (context, state) => const PaymentScreen()),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}