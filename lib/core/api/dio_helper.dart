import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'api_service.dart';

@LazySingleton(as: ApiService)
class DioHelper extends ApiService {
  final Dio dio;

  DioHelper(this.dio);

  @override
  Future<T> get<T>(String url) async {
    final response = await dio.get(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to load data');
    }
    return response.data;
  }
}
