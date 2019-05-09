import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import './radial_position.dart';
import 'package:drizzle/network/model/model.dart';

class SlidingRadialList extends StatelessWidget {
  final weatherData;
  final RadialListViewModel radialList;
  final SlidingRadialListController controller;

  SlidingRadialList({this.radialList, this.controller, this.weatherData});

  List<Widget> _radialListItems() {
    int index = 0;
    return radialList.items.map((RadialListItemViewModel viewModel) {
      final listItem = _radialListItem(
          controller.getItemAngle(index),
          controller.getItemOpacity(index), 
          weatherData[index],
          index == 0  
        );
      ++index;
      return listItem;
    }).toList();
  }

  AssetImage _findIcon(String desc){
    switch(desc.toLowerCase()){
      case 'sunny': return new AssetImage('assets/ic_sunny.png');
      case 'light rain': return new AssetImage('assets/ic_rain.png');
      case 'broken clouds': return new AssetImage('assets/ic_cloudy.png');
      case 'scattered clouds': return new AssetImage('assets/ic_cloudy.png');
      case 'overcast clouds': return new AssetImage('assets/ic_cloudy.png');
      default: return new AssetImage('assets/ic_sunny.png');
    }
  }

  Widget _radialListItem(
      double angle, double opacity, WeatherModel weatherModel, bool isSelected) {
        TimeOfDay time = TimeOfDay.fromDateTime(DateTime.parse(weatherModel.time));
        String weatherHour = time.hour < 10 ? "0"+time.hour.toString() : time.hour.toString();
        String weatherMinutes = time.minute < 10 ? "0"+time.minute.toString() : time.minute.toString();
        String weatherTime = weatherHour+":"+weatherMinutes;
    return new Transform(
      transform: new Matrix4.translationValues(
        40.0,
        300.0,
        0.0,
      ),
      child: new RadialPosition(
        radius: 140.0 + 75.0,
        angle: angle,
        child: new Opacity(
          opacity: opacity,
          child: new RadialListItem(
            listItem: RadialListItemViewModel(
              icon: _findIcon(weatherModel.description),
              title: weatherTime,
              isSelected: isSelected,
              subtitle: weatherModel.description,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return new Stack(
          children: _radialListItems(),
        );
      },
    );
  }
}

class SlidingRadialListController extends ChangeNotifier {
  final double firstItemAngle = -pi / 3;
  final double lastItemAngle = pi / 3;
  final double startSlidingAngle = 3 * pi / 4;

  final int itemCount;
  final AnimationController _slideController;
  final AnimationController _fadeController;
  final List<Animation<double>> _slidePositions;

  RadialListState _state = RadialListState.closed;
  Completer<Null> onOpenedCompleter;
  Completer<Null> onClosedCompleter;

  SlidingRadialListController({
    this.itemCount,
    vsync,
  })  : _slideController = new AnimationController(
          duration: const Duration(milliseconds: 1500),
          vsync: vsync,
        ),
        _fadeController = new AnimationController(
          duration: const Duration(milliseconds: 150),
          vsync: vsync,
        ),
        _slidePositions = [] {
    _slideController
      ..addListener(() => notifyListeners())
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            _state = RadialListState.slidingOpen;
            notifyListeners();
            break;
          case AnimationStatus.completed:
            _state = RadialListState.open;
            notifyListeners();
            onOpenedCompleter.complete();
            break;
          case AnimationStatus.reverse:
          case AnimationStatus.dismissed:
            break;
        }
      });

    _fadeController
      ..addListener(() => notifyListeners())
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            _state = RadialListState.fadingOut;
            notifyListeners();
            break;
          case AnimationStatus.completed:
            _state = RadialListState.closed;
            _slideController.value = 0.0;
            _fadeController.value = 0.0;
            notifyListeners();
            onClosedCompleter.complete();
            break;
          case AnimationStatus.reverse:
          case AnimationStatus.dismissed:
            break;
        }
      });

    final delayInterval = 0.1;
    final slideInterval = 0.5;
    final angleDeltaPerItem =
        (lastItemAngle - firstItemAngle) / (itemCount - 1);
    for (var i = 0; i < itemCount; ++i) {
      final start = delayInterval * i;
      final end = start + slideInterval;

      final endSlidingAngle = firstItemAngle + (angleDeltaPerItem * i);

      _slidePositions.add(new Tween(
        begin: startSlidingAngle,
        end: endSlidingAngle,
      ).animate(new CurvedAnimation(
        parent: _slideController,
        curve: new Interval(start, end, curve: Curves.easeInOut),
      )));
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  double getItemAngle(int index) {
    return _slidePositions[index].value;
  }

  double getItemOpacity(int index) {
    switch (_state) {
      case RadialListState.closed:
        return 0.0;
      case RadialListState.slidingOpen:
      case RadialListState.open:
        return 1.0;
      case RadialListState.fadingOut:
        return (1.0 - _fadeController.value);
      default:
        return 1.0;
    }
  }

  Future<Null> open() {
    if (_state == RadialListState.closed) {
      _slideController.forward();
      onOpenedCompleter = new Completer();
      return onOpenedCompleter.future;
    }
    return null;
  }

  Future<Null> close() {
    if (_state == RadialListState.open) {
      _fadeController.forward();
      onClosedCompleter = new Completer();
      return onClosedCompleter.future;
    }
    return null;
  }
}

enum RadialListState {
  closed,
  slidingOpen,
  open,
  fadingOut,
}

class RadialListItem extends StatelessWidget {
  final RadialListItemViewModel listItem;

  RadialListItem({
    this.listItem,
  });

  @override
  Widget build(BuildContext context) {
    final circleDecoration = listItem.isSelected
        ? new BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          )
        : new BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: new Border.all(
              color: Colors.white,
              width: 2.0,
            ),
          );

    return new Transform(
      transform: new Matrix4.translationValues(-30.0, -30.0, 0.0),
      child: new Row(
        children: <Widget>[
          new Container(
            width: 60.0,
            height: 60.0,
            decoration: circleDecoration,
            child: new Padding(
              padding: const EdgeInsets.all(7.0),
              child: new Image(
                  image: listItem.icon,
                  color: listItem.isSelected
                      ? const Color(0xFF6688CC)
                      : Colors.white),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  listItem.title,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                new Text(
                  listItem.subtitle,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RadialListViewModel {
  final List<RadialListItemViewModel> items;

  RadialListViewModel({
    this.items = const [],
  });
}

class RadialListItemViewModel {
  final ImageProvider icon;
  final String title;
  final String subtitle;
  final bool isSelected;

  RadialListItemViewModel({
    this.icon,
    this.title = '',
    this.subtitle = '',
    this.isSelected = false,
  });
}
