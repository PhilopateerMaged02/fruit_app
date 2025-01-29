import 'package:dio/dio.dart';
import 'package:fruit_app/shared/constants.dart';

class Diohelper {
  static late Dio dio;
  static initDio() {
    dio = Dio(BaseOptions(
      baseUrl: ApiContest.baseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> postDataDio(
      {required String url, Map<String, dynamic>? data}) async {
    return await dio.post(url, data: data);
  }
}
