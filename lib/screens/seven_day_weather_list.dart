import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/model/hourly_daily_alert_model.dart';
import 'package:weather_app/screens/seven_day_weather.dart';
import 'package:weather_app/data/apiclient.dart';

class SevenDayWeatherList extends StatelessWidget {
  static DateFormat _dateFormatWeather = DateFormat("EEEE");
  static DateFormat _dateFormatWeather1 = DateFormat("dd MMM");
  SevenDayWeatherList({
    @required this.dweather,
  }) : assert(dweather != null);
  final Daily dweather;
  // ToDo: Put Date Time


  @override
  Widget build(BuildContext context) {
    // ToDo: Include Date String
    
    return Container(
      height: 50,
      margin: EdgeInsets.only(
        bottom: 10,
        left: 20,
        right: 20,
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          Container(
            width: 50,
            alignment: Alignment.center,
            child: Image.network("http://openweathermap.org/img/wn/${dweather.weather[0].icon}@2x.png"),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: RichText(
                text: TextSpan(
                  text: _dateFormatWeather.format(dweather.dt) + " , ",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(
                     text: _dateFormatWeather1.format(dweather.dt),
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 100,
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                text: '${dweather.temp.max}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text: " / " + '${dweather.feelsLike.day}' + '\u00B0',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
