import 'package:dio/dio.dart';
import 'package:movieapp/Core/Utils/Constants.dart';

class ApiManager {
  Dio dio = Dio();

  Future<Response> getData(String endPoint,{String id ="", String similar="", Map<String, dynamic>? data}) {
    return dio.get(Constants.BaseUrl+endPoint+id+similar, queryParameters: data,options: Options(
    headers: {
      'Authorization': Constants.auth
    }));
  }

  Future<Response> postData(String endPoint, {  Map<String, dynamic>? body}) {
    return dio.post(Constants.BaseUrl+endPoint, data: body);
  }
}
