import 'package:dio/dio.dart';
import 'package:dogs/core_data/dio_settings.dart';
import 'package:dogs/models/cats_model.dart';

class CatsRepo {
  final Dio dio;
  CatsRepo({required this.dio});

  Future<CatsModel> getCatsData() async {
    final response = await dio.get(ApiUrl.cats);
    return CatsModel.fromJson(response.data);
  }
}
