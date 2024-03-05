
import 'package:dio/dio.dart';

import '../local/cachehelper.dart';
class diohelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
headers: {
  'origin':'http://localhost',
  'contentType': 'application/json',
},
        contentType: 'application/json',
        responseType: ResponseType.plain,
        receiveDataWhenStatusError: true,
       ));
  }

  static Future<Response?> getData(
      {required String Url,
        required Map<String, dynamic> query,
        required Token}) async {
   /* diohelper.dio?.options.headers["Authorization"] =
    "Bearer ${StorageUtil.getString('token')}";*/
   /* print(Token);*/
    return await dio?.get(Url, queryParameters: query);
  }

  static Future<Response?> postData(
      {required String Url,
        Map<String, dynamic>? query,
        required Map<String, dynamic> data,
        Token}) async {
 /*   diohelper.dio?.options.headers["Authorization"] =
    "token ${StorageUtil.getString('token')}";*/
    return await dio?.post(Url, queryParameters: query, data: data);
  }
}