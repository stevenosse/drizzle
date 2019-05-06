import 'package:flutter/material.dart';
import 'package:drizzle/forecast/sliding_radial_list.dart';

final RadialListViewModel forecastRadialList = new RadialListViewModel(
  items: [
    RadialListItemViewModel(
      icon: new AssetImage('assets/ic_rain.png'),
      title: '11:30',
      subtitle: 'Light Rain',
      isSelected: true,
    ),
    RadialListItemViewModel(
      icon: new AssetImage('assets/ic_rain.png'),
      title: '12:30P',
      subtitle: 'Light Rain',
    ),
    RadialListItemViewModel(
      icon: new AssetImage('assets/ic_cloudy.png'),
      title: '1:30P',
      subtitle: 'Cloudy',
    ),
    RadialListItemViewModel(
      icon: new AssetImage('assets/ic_sunny.png'),
      title: '2:30P',
      subtitle: 'Sunny',
    ),
    new RadialListItemViewModel(
      icon: new AssetImage('assets/ic_sunny.png'),
      title: '3:30P',
      subtitle: 'Sunny',
    ),
  ],
);