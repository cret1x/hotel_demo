import 'dart:convert';

import 'package:hotel_demo/data/api/api_booking_info.dart';
import 'package:hotel_demo/data/api/api_hotel.dart';
import 'package:hotel_demo/data/api/api_room.dart';
import 'package:http/http.dart' as http;

class MockyService {
  static const _baseUrl = 'https://run.mocky.io/v3';

  Future<ApiHotel> getHotel() async {
    final response = await http.get(Uri.parse("$_baseUrl/35e0d18e-2521-4f1b-a575-f0fe366f66e3"));
    if (response.statusCode != 200) {
      throw Exception("${response.statusCode}");
    }
    return ApiHotel.fromApi(jsonDecode(response.body));
  }

  Future<List<ApiRoom>> getRooms() async {
    final response = await http.get(Uri.parse("$_baseUrl/f9a38183-6f95-43aa-853a-9c83cbb05ecd"));
    if (response.statusCode != 200) {
      throw Exception("${response.statusCode}");
    }
    List<dynamic> roomsJson = jsonDecode(response.body)['rooms'];
    return List.from(roomsJson.map((room) => ApiRoom.fromApi(room)));
  }
  
  Future<ApiBookingInfo> getBookingInfo() async {
    final response = await http.get(Uri.parse("$_baseUrl/e8868481-743f-4eb2-a0d7-2bc4012275c8"));
    if (response.statusCode != 200) {
      throw Exception("${response.statusCode}");
    }
    return ApiBookingInfo.fromApi(jsonDecode(response.body));
  }
}