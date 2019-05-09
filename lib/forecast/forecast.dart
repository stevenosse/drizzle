import 'package:flutter/material.dart';
import './background/Background.dart';
import './sliding_radial_list.dart';
import 'forecast_list.dart';
import 'package:drizzle/network/model/model.dart';

class Forecast extends StatelessWidget {
  final double unit = -273.15;
  final List<WeatherModel> data;
  final RadialListViewModel radialList;
  final SlidingRadialListController slidingListController;

  Forecast({
    @required this.radialList,
    @required this.slidingListController,
    this.data
  });

  int _parseToCelsius(double temperature){
    return (temperature+unit).toInt();
  }

  Widget _temperatureText(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0, left: 30.0),
        child: Text(
          this._parseToCelsius(data[0].temperature).toString()+"°",
          style: TextStyle(
            color: Colors.white,
            fontSize: 80.0
          )
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Background(),
        _temperatureText(),
        SlidingRadialList(
          weatherData: this.data,
          radialList: forecastRadialList,
          controller: slidingListController,
        ),

        //Rain(),
      ],
    );
  }
}