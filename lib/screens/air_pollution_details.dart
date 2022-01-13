import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/src/provider.dart';
import 'package:weather_app/data/api_interface.dart';
import 'package:weather_app/data/model/air_pollution_aqi.dart';
import 'package:weather_app/screens/view_model/cood_view_model.dart';

import 'air_pollution.dart';
import 'city_weather.dart';
import 'home_screen.dart';

class AirPollutionDetails extends StatefulWidget {
  const AirPollutionDetails({Key key}) : super(key: key);


  @override
  State<AirPollutionDetails> createState() => _AirPollutionDetails();
}

class _AirPollutionDetails extends State<AirPollutionDetails> {
  APIInterface apiinterface;
  AqiData aqi;




  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    EasyLoading.show(status: 'Accu-Weather is loading...');
    apiinterface = APIInterfaceImpl();
    final position = context.watch<COODViewModel>().position;
    aqi = await apiinterface.getAQIData(position.longitude, position.latitude);
    setState(() {
      EasyLoading.dismiss();
    });

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
        body: Column(
          children: [
            Container(
              height: 20,
            ),
            Container(
              height: 30,
              margin: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              child: Text(
                "Air pollution Details..!",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              height: 20,
            ),

            Container(
              width: MediaQuery.of(context).size.width - 20,
              height:65,
              decoration: BoxDecoration(
                  color:  Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow:  [
                    BoxShadow(
                        color:
                        Theme.of(context).primaryColor.withOpacity(0.2),
                        spreadRadius: 10,
                        blurRadius: 10),
                  ],
                  border: Border.all(
                      color: Colors.grey[300])),
              padding: const EdgeInsets.only(left: 25, right:25, top:15, bottom:15),
              child: Row(
                children:[
                  Text('co', style: TextStyle(color: Colors.black,fontSize: 20)),
                  Spacer(),
                  Text('${aqi != null ? aqi.list[0].components['co']: ''}', style: TextStyle(color: Colors.black,fontSize: 20)),
                ]
              ),
            ),





            Container(
              height: 20,
            ),

            Container(
              width: MediaQuery.of(context).size.width - 20,
              height:65,
              decoration: BoxDecoration(
                  color:  Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow:  [
                    BoxShadow(
                        color:
                        Theme.of(context).primaryColor.withOpacity(0.2),
                        spreadRadius: 10,
                        blurRadius: 10),
                  ],
                  border: Border.all(
                      color: Colors.grey[300])),
              padding: const EdgeInsets.only(left: 25, right:25, top:15, bottom:15),
              child: Row(
                  children:[
                    Text('no', style: TextStyle(color: Colors.black,fontSize: 20)),
                    Spacer(),
                    Text('${aqi != null ? aqi.list[0].components['no']: ''}', style: TextStyle(color: Colors.black,fontSize: 20)),
                  ]
              ),
            ),


            Container(
              height: 20,
            ),

            Container(
              width: MediaQuery.of(context).size.width - 20,
              height:65,
              decoration: BoxDecoration(
                  color:  Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow:  [
                    BoxShadow(
                        color:
                        Theme.of(context).primaryColor.withOpacity(0.2),
                        spreadRadius: 10,
                        blurRadius: 10),
                  ],
                  border: Border.all(
                      color: Colors.grey[300])),
              padding: const EdgeInsets.only(left: 25, right:25, top:15, bottom:15),
              child: Row(
                  children:[
                    Text('no2', style: TextStyle(color: Colors.black,fontSize: 20)),
                    Spacer(),
                    Text('${aqi != null ? aqi.list[0].components['no2']: ''}', style: TextStyle(color: Colors.black,fontSize: 20)),
                  ]
              ),
            ),


            Container(
              height: 20,
            ),

            Container(
              width: MediaQuery.of(context).size.width - 20,
              height:65,
              decoration: BoxDecoration(
                  color:  Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow:  [
                    BoxShadow(
                        color:
                        Theme.of(context).primaryColor.withOpacity(0.2),
                        spreadRadius: 10,
                        blurRadius: 10),
                  ],
                  border: Border.all(
                      color: Colors.grey[300])),
              padding: const EdgeInsets.only(left: 25, right:25, top:15, bottom:15),
              child: Row(
                  children:[
                    Text('o3', style: TextStyle(color: Colors.black,fontSize: 20)),
                    Spacer(),
                    Text('${aqi != null ? aqi.list[0].components['o3']: ''}', style: TextStyle(color: Colors.black,fontSize: 20)),
                  ]
              ),
            ),



            Container(
              height: 20,
            ),

            Container(
              width: MediaQuery.of(context).size.width - 20,
              height:65,
              decoration: BoxDecoration(
                  color:  Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow:  [
                    BoxShadow(
                        color:
                        Theme.of(context).primaryColor.withOpacity(0.2),
                        spreadRadius: 10,
                        blurRadius: 10),
                  ],
                  border: Border.all(
                      color: Colors.grey[300])),
              padding: const EdgeInsets.only(left: 25, right:25, top:15, bottom:15),
              child: Row(
                  children:[
                    Text('so2', style: TextStyle(color: Colors.black,fontSize: 20)),
                    Spacer(),
                    Text('${aqi != null ? aqi.list[0].components['so2']: ''}', style: TextStyle(color: Colors.black,fontSize: 20)),
                  ]
              ),
            ),


            Container(
              height: 20,
            ),

            Container(
              width: MediaQuery.of(context).size.width - 20,
              height:65,
              decoration: BoxDecoration(
                  color:  Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow:  [
                    BoxShadow(
                        color:
                        Theme.of(context).primaryColor.withOpacity(0.2),
                        spreadRadius: 10,
                        blurRadius: 10),
                  ],
                  border: Border.all(
                      color: Colors.grey[300])),
              padding: const EdgeInsets.only(left: 25, right:25, top:15, bottom:15),
              child: Row(
                  children:[
                    Text('nh3', style: TextStyle(color: Colors.black,fontSize: 20)),
                    Spacer(),
                    Text('${aqi != null ? aqi.list[0].components['nh3']: ''}', style: TextStyle(color: Colors.black,fontSize: 20)),
                  ]
              ),
            ),

          ],
        ),
      ),
    );
  }


}
