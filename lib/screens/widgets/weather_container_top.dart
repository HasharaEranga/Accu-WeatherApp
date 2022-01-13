import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherContainerTop extends StatelessWidget {

  static DateFormat _dateFormatWeather = DateFormat("EEEE, dd MMM");

  final String icon;
  final String description;
  final DateTime dt;
  final double temp;

  WeatherContainerTop(
      { this.icon,
        this.description,
        this.dt,
        this.temp,}
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 6,
          child: Column(
            children: [
              Expanded(
                child: Image(
                  image: NetworkImage(
                    'http://openweathermap.org/img/wn/$icon@4x.png',
                  ),
                ),
                flex: 4,
              ),
              Expanded(
                child: Column(
                  children: [
                    Flexible(
                      child: Text(
                        description,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Flexible(
                      child: Text(
                          _dateFormatWeather.format(dt),
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Theme.of(context).primaryColorLight)),
                    ),
                  ],
                ),
                flex: 3,
              )

            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Center(
            child: Text(
              temp.toString() + '\u00B0',
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );

  }
}
