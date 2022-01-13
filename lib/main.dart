import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/city_weather.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/screens/login_screen.dart';
import 'package:weather_app/screens/registration_screen.dart';
import 'package:weather_app/screens/seven_day_weather.dart';
import 'package:weather_app/screens/splash_screen.dart';
import 'package:weather_app/screens/view_model/cood_view_model.dart';
import 'package:weather_app/screens/air_pollution_details.dart';
import 'package:weather_app/screens/air_pollution.dart';

import 'database/database.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => COODViewModel()),
        Provider(create: (_) => WeatherAppDatabase()),
      ],
      child: MaterialApp(
        title: 'Accu Weather',
        builder: EasyLoading.init(),
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          'login': (context) => LoginScreen(),
          'registration': (context) => RegistrationScreen(),
          'home': (context) => HomeScreen(),
          '7day': (context) => SevenDayWeather(),
          'alerts': (context) => AirPollutionDetails(),
          'airpollution': (context) => AirPollution(),
          'cityweather': (context) => CityWeather(),


        },
      ),

    );
  }
}


