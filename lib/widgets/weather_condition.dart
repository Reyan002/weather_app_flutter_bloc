import 'package:flutter/material.dart';

import 'package:practice1/models/models.dart';

class WeatherConditions extends StatelessWidget {
  final WeatherCondition condition;

  WeatherConditions({Key key, @required this.condition})
      : assert(condition != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => _mapConditionToImage(condition);

  Image _mapConditionToImage(WeatherCondition condition) {
    Image image;
    switch (condition) {
      case WeatherCondition.clear:
      case WeatherCondition.lightCloud:
        image = Image.asset('assets/clear.png',height: 100,width: 100,);
        break;
      case WeatherCondition.hail:
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
        image = Image.asset('assets/snow.png',height: 100,width: 100,);
        break;
      case WeatherCondition.heavyCloud:
        image = Image.asset('assets/cloudy.png',height: 100,width: 100,);
        break;
      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
        image = Image.asset('assets/rainy.png',height: 100,width: 100,);
        break;
      case WeatherCondition.thunderstorm:
        image = Image.asset('assets/thunderstorm.png',height: 100,width: 100,);
        break;
      case WeatherCondition.unknown:
        image = Image.asset('assets/clear.png',height: 100,width: 100,);
        break;
    }
    return image;
  }
}