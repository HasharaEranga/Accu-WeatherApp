
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weather_app/data/api_interface.dart';
import 'package:weather_app/data/apiclient.dart';
import 'package:weather_app/data/model/air_pollution_aqi.dart';
import 'package:weather_app/screens/view_model/cood_view_model.dart';
import 'package:provider/provider.dart';


import 'home_screen.dart';

class AirPollution extends StatefulWidget {
  const AirPollution({Key key}) : super(key: key);

  @override
  State<AirPollution> createState() => _AirPollutionState();
}

class _AirPollutionState extends State<AirPollution> {
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
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
                /*text: timeZoneData[0] + " , ",*/
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    /*text: timeZoneData[1] + " , ",*/
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
                "Air Pollution in Your Area",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              height: 30,
            ),
            
            Expanded(
              child: Container(
                child: SfRadialGauge(

                  title: GaugeTitle(text: 'Air Index Meter', textStyle: TextStyle(fontSize: 20,fontFamily: 'Lato',color: Colors.purple
                      ,fontWeight: FontWeight.bold)),
                  axes: <RadialAxis>[RadialAxis(minimum: 0, maximum: 5,
                    ranges: <GaugeRange>[GaugeRange(startValue: 0, endValue: 1,color: Colors.lightGreenAccent,startWidth: 10,endWidth: 10),
                    GaugeRange(startValue: 1, endValue: 2, color: Colors.green,startWidth: 10, endWidth: 10),
                    GaugeRange(startValue: 2, endValue: 3, color: Colors.amber, startWidth: 10, endWidth: 10),
                    GaugeRange(startValue: 3, endValue: 4, color: Colors.orange, startWidth: 10, endWidth: 10),
                    GaugeRange(startValue: 4, endValue: 5, color: Colors.red, startWidth: 10, endWidth: 10)
                    ],
                  pointers: <GaugePointer>[NeedlePointer(value: aqi != null ? aqi.list[0].main.aqi.toDouble(): 0)],
                  annotations: <GaugeAnnotation>[GaugeAnnotation(widget: Container(
                    child: Text('${aqi != null ? aqi.list[0].main.aqi: 0}', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                  ),
                  angle: 90, positionFactor: 0.5,
                  )],
                  )],
                ),
              ),
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    color: Colors.lightGreen,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text('Very Good'),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text('Good'),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    color: Colors.amber,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text('Normal'),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    color: Colors.orange,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text('Poor'),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text('Very Poor'),
                ]

              ),
            ),
            SizedBox(height:20),
            // SizedBox(
            //   height: 80,
            //   child: ListView(
            //       children: [
            //         AirPollutionDetails(value: '${aqi != null ? aqi.list[0].components['co']: ''}',air: 'co',),
            //         AirPollutionDetails(value: '${aqi != null ? aqi.list[0].components['no']: ''}',air: 'no',),
            //         AirPollutionDetails(value: '${aqi != null ? aqi.list[0].components['no2']: ''}',air: 'no2',),
            //         AirPollutionDetails(value: '${aqi != null ? aqi.list[0].components['o3']: ''}',air: 'o3',),
            //         AirPollutionDetails(value: '${aqi != null ? aqi.list[0].components['so2']: ''}',air: 'so2',),
            //         AirPollutionDetails(value: '${aqi != null ? aqi.list[0].components['nh3']: ''}',air: 'nh3',),                   ],
            //     scrollDirection: Axis.horizontal,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
//
// class AirPollutionDetails extends StatelessWidget {
//
//  final  String air;
//  final  String value;
//   const AirPollutionDetails({Key key, this.air, this.value}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//       child: InkWell(
//         child: Container(
//           decoration: BoxDecoration(
//               color:  Colors.green,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow:  [
//                 BoxShadow(
//                     color:
//                     Theme.of(context).primaryColor.withOpacity(0.2),
//                     spreadRadius: 10,
//                     blurRadius: 10),
//               ],
//               border: Border.all(
//                   color: Colors.grey[300])),
//           padding: const EdgeInsets.all(8),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//
//               Expanded(
//                 child: Text(
//                   value,
//                   style:Theme.of(context).textTheme.headline6.copyWith(
//                       color:  Colors.black54,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Expanded(
//                 child: Text(
//                   air,
//                   style: TextStyle(color: Colors.black,fontSize: 10),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


