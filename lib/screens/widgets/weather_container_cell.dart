import 'package:flutter/material.dart';

class WeatherContainerCell extends StatelessWidget {
  final String text;
  final String value;
  final String icon;

  WeatherContainerCell(
      {this.text, this.value, this.icon}
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex:2,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image(
              image: AssetImage('images/$icon.png'),
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.black),
              ),
              Text(
                value,
                style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white),
              ),
            ],
          ),

        ),
      ]
    );
  }
}
