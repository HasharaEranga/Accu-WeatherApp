import 'package:weather_app/data/apiclient.dart';

import 'model/air_pollution_aqi.dart';
import 'model/hourly_daily_alert_model.dart';

abstract class APIInterface{
  Future<HourlyDailyAlertWeather> getWeatherData(double lon, double lat);
  Future<AqiData> getAQIData(double lon, double lat);


}

class APIInterfaceImpl extends APIInterface{

  ApiClient apiclient;

  APIInterfaceImpl(){
    apiclient = ApiClient();
  }

  @override
  Future<AqiData> getAQIData(double lon, double lat) async {
    final response = await apiclient.get({'lon': lon, 'lat': lat},
        'air_pollution?appid=5824c6bef07a35f5fa9b1d14ec52f8a9');
    return  AqiData.fromJson(response);
  }

  @override
  Future<HourlyDailyAlertWeather> getWeatherData(double lon, double lat) async {
    final response = await apiclient.get({'lon': lon, 'lat': lat},
        'onecall?units=metric&appid=5824c6bef07a35f5fa9b1d14ec52f8a9');
    return  HourlyDailyAlertWeather.fromJson(response);
  }

}