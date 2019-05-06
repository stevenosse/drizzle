import 'package:flutter/material.dart';
import './background/Background.dart';
import './sliding_radial_list.dart';
import 'forecast_list.dart';

class Forecast extends StatelessWidget {
  
  final RadialListViewModel radialList;
  final SlidingRadialListController slidingListController;

  Forecast({
    @required this.radialList,
    @required this.slidingListController
  });

  Widget _temperatureText(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0, left: 30.0),
        child: Text(
          '68°',
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
          radialList: forecastRadialList,
          controller: slidingListController,
        ),

        //Rain(),
      ],
    );
  }
}