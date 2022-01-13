import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/apiclient.dart';
import 'package:weather_app/data/model/air_pollution.dart';
import 'package:weather_app/data/model/current_weather_data_model.dart';
import 'package:weather_app/screens/view_model/cood_view_model.dart';
import 'package:provider/provider.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    ApiClient obj = ApiClient();
    // final weather = await obj.get({'q':'Horana'},'weather?appid=5824c6bef07a35f5fa9b1d14ec52f8a9');
    // final currentweather = CurrentWeatherData.fromJson(weather);
    // print(currentweather.name);

    // final air = await obj.get({'lon': 80.0619,'lat': 6.7166},'air_pollution?appid=5824c6bef07a35f5fa9b1d14ec52f8a9');
    // final airpollution = AirPollution.fromJson(air);
    // print(airpollution.list[0].main.aqi);

    final position = await _determinePosition();
    print('${position.longitude},${position.latitude}');

    if(position == null){
      print('Enable Your Locations..!!');
    }
    else{
      /*Navigator.pushReplacementNamed(context, 'home');*/
      Future.delayed(Duration(seconds: 3),(){
        Navigator.pushNamed(context, 'login');
      });
    }

  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    final position = await Geolocator.getCurrentPosition();
    context.read<COODViewModel>().updatePosition(position);

        // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(
              image:AssetImage(
                'images/accuweather.png',
              ),
              height: 200,
              width: 200,

            ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(
              'Accu-Weather',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 24, fontFamily: 'Roboto',fontWeight: FontWeight.bold),
            ),
          ),
          ],
        ),

      ),

    );
  }
}
