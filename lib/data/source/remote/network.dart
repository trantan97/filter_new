import 'package:dio/dio.dart';
import 'package:filter_news/data/source/remote/api_const.dart';

class Network {
  int _timeOut = 10000; //10 s
  Dio _dio;

  Network() {
    BaseOptions options = BaseOptions(
      connectTimeout: _timeOut,
      receiveTimeout: _timeOut,
      baseUrl: ApiConst.BASE_URL,
      queryParameters: {"apiKey": ApiConst.API_KEY},
    );
    _dio = Dio(options);
    _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  Future<Response> get(
      {String url, Map<String, dynamic> params, Options options, ProgressCallback onReceiveProgress}) async {
    try {
      return await _dio.get(
        url,
        queryParameters: params,
        options: options,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioError catch (e) {
      print("DioError: ${e.toString()}");
    }
  }

  Future download({String url, String filePath, ProgressCallback onReceiveProgress}) async {
    await _dio.download(url, filePath, onReceiveProgress: onReceiveProgress);
  }
}
