
import 'package:flutter/material.dart';
import 'package:weather_app/data/apiclient.dart';
import 'package:weather_app/data/model/hourly_daily_alert_model.dart';
import 'package:weather_app/screens/seven_day_weather_list.dart';

import 'home_screen.dart';

/*class SevenDayWeather extends StatefulWidget {
  const SevenDayWeather({Key key}) : super(key: key);

  @override
  _SevenDayWeatherState createState() => _SevenDayWeatherState();
}

class _SevenDayWeatherState extends State<SevenDayWeather> {

  HourlyDailyAlertWeather dweather;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    ApiClient obj = ApiClient();
    final weather = await obj.get({'lon': 80.0619, 'lat': 6.7166},'onecall?appid=5824c6bef07a35f5fa9b1d14ec52f8a9');
    dweather = HourlyDailyAlertWeather.fromJson(weather);
    setState(() {

    });
  }*/

class SevenDayWeather extends StatelessWidget {

  const SevenDayWeather({
    @required this.dweather,
    @required this.timeZone,
  }) : assert(dweather != null);
  final List<Daily> dweather;
  final String timeZone;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.wb_twighlight), color: Colors.black, onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return HomeScreen();
              },),);
            },)

          ],
          title: Center(
            child: RichText(
              text: TextSpan(
                text: timeZone.split("/").first+ ' ',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black
                ),
                children: [
                  TextSpan(
                    text: timeZone.split("/").last,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 20,
            ),
            Container(
              height: 30,
              margin: EdgeInsets.symmetric( horizontal: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                "Weather of Next 7 Days",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              height: 20,
            ),
            ListView.builder( shrinkWrap: true,
            itemCount: dweather.length,
            itemBuilder: (BuildContext context, int index){
              return SevenDayWeatherList(
                dweather: dweather[index]);
            }
            ),
          ],
        ),
      ),
    );
  }
}
