import 'package:dio/dio.dart';
import 'package:dogs/core_data/dio_settings.dart';
import 'package:dogs/models/dogs_model.dart';

class GetDogsRepo {
  final Dio dio;
  GetDogsRepo({required this.dio});

  Future<DogsModel> getDogsData({required int count}) async {
    final response = await dio.get('${ApiUrl.dogs}$count');
    return DogsModel.fromJson(response.data);
  }
}
