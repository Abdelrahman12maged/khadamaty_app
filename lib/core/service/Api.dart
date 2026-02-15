import 'package:dio/dio.dart';

class Apiservice {
  final Dio dio;

  Apiservice({required this.dio});

  // Future<Map<String, dynamic>> getdio(
  //     {required String url, Map<String, dynamic>? queryParameters}) async {
  //   var resposne = await dio.get(url, queryParameters: queryParameters);
  //   return resposne.data;
  // }

  Future<Response> postdio(
      {required String url,
      required String? token,
      String? contentType,
      Map<String, dynamic>? extraHeaders,
      required body}) async {
    final headers = <String, dynamic>{
      "Authorization": "Bearer $token",
    };
    if (extraHeaders != null) {
      headers.addAll(extraHeaders);
    }
    var resposne = await dio.post(url,
        data: body,
        options: Options(
            contentType: contentType ?? 'application/x-www-form-urlencoded',
            headers: headers));
    return resposne;
  }
}
