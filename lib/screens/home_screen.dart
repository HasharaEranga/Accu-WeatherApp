import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/api_interface.dart';
import 'package:weather_app/data/apiclient.dart';
import 'package:weather_app/data/model/current_weather_data_model.dart';
import 'package:weather_app/data/model/hourly_daily_alert_model.dart';
import 'package:weather_app/screens/air_pollution.dart';
import 'package:weather_app/screens/seven_day_weather.dart';
import 'package:weather_app/screens/view_model/cood_view_model.dart';
import 'package:weather_app/screens/air_pollution_details.dart';
import 'package:weather_app/screens/widgets/weather_container_cell.dart';
import 'package:weather_app/screens/widgets/weather_container_top.dart';
import 'package:provider/provider.dart';
import 'city_weather.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HourlyDailyAlertWeather cweather;
  APIInterface apiinterface;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    EasyLoading.show(status: 'Accu-Weather is loading...');
    apiinterface = APIInterfaceImpl();
    final position = context.watch<COODViewModel>().position;
    cweather = await apiinterface.getWeatherData(position.longitude, position.latitude);
    print(cweather.current.pressure);
    setState(() {
      EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
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
          actions: [IconButton(icon: Icon(Icons.wb_sunny_sharp), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return AirPollutionDetails();
            },),);
          })],

            iconTheme: IconThemeData(color: Colors.black87),
          ),
        body: HomePageBody(
          cweather: cweather,

        ),
      ),
    );
  }

}


class HomePageBody extends StatelessWidget {

  final HourlyDailyAlertWeather cweather;

  const HomePageBody({Key key, this.cweather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          // ToDo: Calling TopTimeZone Class
          child: TopTimeZone(
            timezone: cweather != null ? cweather.timezone: '',
          ),
        ),
        Expanded(
          flex: 8,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: WeatherContainer(cweather: cweather,),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  'Today',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                GestureDetector(
                  // ToDo: Access Daily Weather Details Page
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return SevenDayWeather(
                          dweather: cweather.daily, timeZone: cweather.timezone,
                        );
                      },
                    ));
                    // TODO: Provide Access to Next 7 Days Weather Details Page
                  },
                  child: Row(
                    children: [
                      Text(
                        "Next 7 Days",
                        style: TextStyle(color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black54, size: 18,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            flex: 3,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                    cweather != null ? cweather.hourly.length: 0,
                        (index) => index == 0
                        ? ListItem(
                      dt: cweather != null ? cweather.current.dt: DateTime.now(),
                      icon: cweather != null ? cweather.current.weather[0].icon: '',
                      temp: cweather != null ? cweather.current.temp: 0.0,
                      index: index,
                      isSelected: false,
                    )
                        : ListItem(
                      dt: cweather != null ? cweather.hourly[index - 1].dt: DateTime.now(),
                      icon: cweather != null ? cweather.hourly[index - 1].weather[0].icon: '',
                      temp: cweather != null ? cweather.hourly[index - 1].temp: 0.0,
                      index: index,
                      isSelected: false,
                    ))),),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}


class WeatherContainer extends StatelessWidget {
  // ToDo: Global Variable
  final HourlyDailyAlertWeather cweather;

  const WeatherContainer({Key key, this.cweather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurpleAccent.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 8,
          ),
        ],
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 8,
            // ToDo: Calling Weather Container Top Class
            child: WeatherContainerTop(
              icon: cweather != null
                  ? cweather.current.weather[0].icon
                  : '10n',
              description: cweather != null ? cweather.current.weather[0]
                  .description : ' ',
              dt: cweather != null ? cweather.current.dt : DateTime.now(),
              temp: cweather != null ? cweather.current.temp : 0.0,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                      color: Colors.white
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: WeatherContainerCell(
                      icon: "thermo",
                      text: "Feels like:",
                      value: cweather != null ? cweather.current.feelsLike.toString() + '\u00B0': '',

                    ),
                  ),
                  Container(
                    width: 1,
                    height: double.maxFinite,
                    color: Colors.white,
                  ),
                  Expanded(
                    child: WeatherContainerCell(
                      icon: "wind",
                      text: "Wind Speed:",
                      value: cweather != null ? cweather.current.windSpeed.toString()+'Km/h': '',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(),
                child: Row(
                  children: [
                    Expanded(
                      child: WeatherContainerCell(
                        icon: "sun",
                        text: "UV Index:",
                        value: cweather != null ? cweather.current.uvi.toString(): '',
                      ),
                    ),
                    Container(
                      width: 1,
                      height: double.maxFinite,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    Expanded(
                      child: WeatherContainerCell(
                        icon: "pressure",
                        text: "Pressure:",
                        value:cweather != null ? cweather.current.pressure.toString() + 'mbar': '',
                      ),
                    ),
                  ],
                ),
              )),

        ],
      ),
    );
  }
}

class TopTimeZone extends StatelessWidget {
  final String timezone;

  TopTimeZone({@required this.timezone});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: RichText(
            text: TextSpan(
                text: timezone.split('/').first + ', ',
                style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Colors.black87,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: timezone.split('/').last,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Colors.grey),
                  )
                ])),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final DateTime dt;
  final String icon;
  final double temp;
  final int index;
  final bool isSelected;
  static DateFormat _timeFormatWeather = DateFormat("HH:mm");

  ListItem(
      { @required this.dt,
        @required this.icon,
        @required this.temp,
        @required this.index,
        @required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.green,
              borderRadius: BorderRadius.circular(12),
              boxShadow: isSelected
                  ? [
                BoxShadow(
                    color:
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    spreadRadius: 10,
                    blurRadius: 10),
              ]
                  : null,
              border: Border.all(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey[300])),
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Expanded(
                child: Image.network(
                  "http://openweathermap.org/img/wn/$icon@2x.png",
                  color: isSelected ? Colors.white : null,
                ),
              ),
              Expanded(
                child: Text(
                  index == 0 ? "Now" : temp.toString() + '\u00B0',
                  style: index == 0
                      ? Theme.of(context).textTheme.subtitle1.copyWith(
                      color: isSelected ? Colors.white : Colors.black54,
                      fontWeight: FontWeight.bold)
                      : Theme.of(context).textTheme.headline6.copyWith(
                      color: isSelected ? Colors.white : Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                 index == 0 ? '' : _timeFormatWeather.format(dt),
                  style: TextStyle(color: Colors.black,fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}








  


