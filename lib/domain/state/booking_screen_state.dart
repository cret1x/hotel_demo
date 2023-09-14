import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_demo/domain/model/booking_info.dart';
import 'package:hotel_demo/domain/model/tourist.dart';
import 'package:hotel_demo/domain/repository/booking_info_repository.dart';
import 'package:hotel_demo/domain/state/providers/tourists_list_provider.dart';
import 'package:hotel_demo/internal/dependencies/repository_module.dart';

final bookingProvider = FutureProvider<BookingInfo>((ref) {
  final BookingInfoRepository bookingInfoRepository = RepositoryModule.bookingInfoRepository();
  return bookingInfoRepository.getBookingInfo();
});

final touristListProvider = StateNotifierProvider<TouristsListProvider, List<Tourist>>((ref) => TouristsListProvider());