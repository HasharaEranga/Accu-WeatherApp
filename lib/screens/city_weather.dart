import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/src/provider.dart';
import 'package:weather_app/data/api_interface.dart';
import 'package:weather_app/data/apiclient.dart';
import 'package:weather_app/data/model/air_pollution_aqi.dart';
import 'package:weather_app/screens/air_pollution_details.dart';
import 'package:weather_app/screens/view_model/cood_view_model.dart';

import 'air_pollution.dart';
import 'home_screen.dart';

class CityWeather extends StatefulWidget {
  const CityWeather({Key key}) : super(key: key);



  @override
  State<CityWeather> createState() => _CityWeather();
}

class _CityWeather extends State<CityWeather> {

  APIInterface apiinterface;
  AqiData aqi;
  ApiClient apiclient = ApiClient();
  var weatherData = [];


  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    EasyLoading.show(status: 'Accu-Weather is loading...');
    apiinterface = APIInterfaceImpl();

    var citiesId = [{'id': 1248991, 'name': 'Colombo' },{'id': 1609348, 'name': 'Bangkok' }, {'id': 1261481, 'name': 'New Delhi' }, {'id': 1850147, 'name': 'Tokyo' },{'id': 2643741, 'name': 'London' },{'id': 3143244, 'name': 'Oslo' },{'id': 524894, 'name': 'Moscow' },{'id': 3169070, 'name': 'Rome' },{'id': 1816670, 'name': 'Beijing' },{'id': 6554238, 'name': 'Jerusalem' },{'id': 3054638, 'name': 'Budapest' },{'id': 5128581, 'name': 'New York' },{'id': 7800827, 'name': 'Kathmandu' },{'id': 6619279, 'name': 'Sydney' },{'id': 2193732, 'name': 'Auckland' }];

    for(var c in citiesId){
      getcityweather(c['id']).then((data){
        var dt = [];

        dt.add({
          'name':c['name'],
          'icon' : data['weather'][0]['icon'],
          'temp' : data['main']['temp'],
          'feels_like' : data['main']['feels_like'],

        });

        weatherData.add(dt);
        print(weatherData);

        setState(() {
          EasyLoading.dismiss();
        });
      });
    }

  }

  getcityweather(id) async {
    final response = await apiclient.get({'id': id},
        'weather?appid=5824c6bef07a35f5fa9b1d14ec52f8a9');
    //print(response);
    return response;
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    image: DecorationImage(image: AssetImage("images/weather.png"),fit:BoxFit.cover)
                ),
                child: Text('Welcome Accu-Weather App..!!', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),),
              ),

              ListTile(
                title: const Text('Air Pollution',style: TextStyle(fontFamily: 'Lato',fontWeight: FontWeight.bold, fontSize: 16),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return AirPollution(

                      );
                    },
                  ));
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Weather in Cities',style: TextStyle(fontFamily: 'Lato',fontWeight: FontWeight.bold, fontSize: 16),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return CityWeather(

                      );
                    },
                  ));

                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Air Pollution Details', style: TextStyle(fontFamily: 'Lato',fontWeight: FontWeight.bold, fontSize: 16),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return AirPollutionDetails(

                      );
                    },
                  ));// Update the state of the app.// ...
                },
              ),
            ],
          ),
        ),
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
                //text: timeZone.split("/").first+.' ',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    // text: timeZone.split("/").last,
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
        body:
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 20,
              ),
              Container(
                height: 30,
                margin: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: Text(
                  "Weather of Cities around the World",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                height: 20,
              ),


          for(var d in weatherData)
      Container(
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
              child: Image.network("http://openweathermap.org/img/wn/${d[0]['icon']}@2x.png"),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: RichText(
                  text: TextSpan(
                    text: '${d[0]['name']}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    children: [
                      // TextSpan(
                      //   text: '${d[0]['name']}',
                      //   style: TextStyle(
                      //     color: Colors.white60,
                      //     fontSize: 18,
                      //   ),
                      // ),
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
                  text: '${d[0]['temp']}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: " / " + '${d[0]['feels_like']}' + '\u00B0',
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
    ),

            ],
          ),
        ),
      ),
    );
  }
}
