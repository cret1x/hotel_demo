import 'package:hotel_demo/data/api/api_util.dart';
import 'package:hotel_demo/data/api/service/mocky_service.dart';

class ApiModule {
  static ApiUtil? _apiUtil;
  static ApiUtil apiUtil() {
    _apiUtil ??= ApiUtil(MockyService());
    return _apiUtil!;
  }
}