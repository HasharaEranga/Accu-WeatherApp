import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weather_app/data/model/current_weather_data_model.dart';

class ApiClient{
  String url = 'https://api.openweathermap.org/data/2.5/';
  Dio dio;

  ApiClient(){
    dio = Dio(BaseOptions(baseUrl: url,contentType: "application/json" ));

  }

  get(Map<String , dynamic> queryparameters, String contextpath) async{
    final result = await dio.get(url + contextpath, queryParameters: queryparameters);
    return result.data;
  }


}