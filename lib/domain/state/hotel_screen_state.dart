import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_demo/domain/model/hotel.dart';
import 'package:hotel_demo/domain/repository/hotel_repository.dart';
import 'package:hotel_demo/internal/dependencies/repository_module.dart';

final hotelProvider = FutureProvider<Hotel>((ref) {
  final HotelRepository hotelRepository = RepositoryModule.hotelRepository();
  return hotelRepository.getHotel();
});