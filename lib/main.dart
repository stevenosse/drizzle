import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './forecast/weekdrawer.dart';
import './forecast/forecastappbar.dart';
import './widgets/sliding_drawer.dart';
import './forecast/Weather.dart';
import './forecast/forecast.dart';
import './forecast/forecast_list.dart';
import './forecast/sliding_radial_list.dart';
import './widgets/modal.dart';
import './widgets/spinner_city.dart';
import 'env.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drizzle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  OpenableController openableController;
  SlidingRadialListController slidingController;
  final week = [];
  final List days = new List();
  Modal modal;

  String selectedDay;
  String selectedCity;

  _initData() {
    days.add("Lundi");
    days.add("Mardi");
    days.add("Mercredi");
    days.add("Jeudi");
    days.add("Vendredi");
    days.add("Samedi");
    days.add("Dimanche");
    for (var i = 0; i < 7; i++) {
      week.add(DateTime.now().add(new Duration(days: i)));
    }
    DateTime date = week.first;
    selectedDay = days[date.weekday - 1] +
        "\n" +
        date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString();
    modal = new Modal();
    selectedCity = modal.seletedItem.toString();
  }

  Future<Weather> getWeatherData(String city) async {
    final String url = Env.API_URL+"?q="+city+"&appid="+Env.MAP_API_KEY;
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    print(response.body);
  }

  @override
  void initState() {
    this._initData();
    super.initState();
    openableController = new OpenableController(
        vsync: this, openDuration: Duration(milliseconds: 250))
      ..addListener(() => setState(() => {}));

    slidingController = new SlidingRadialListController(
        itemCount: forecastRadialList.items.length, vsync: this)
      ..open();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Stack(children: <Widget>[
      Forecast(
        radialList: forecastRadialList,
        slidingListController: slidingController,
      ),
      Positioned(
        top: 0.0,
        left: 0.0,
        right: 0.0,
        child: ForcastAppBar(
            onDrawerArrowTap: () {
              openableController.open();
            },
            selectedDay: selectedDay,
            spinnerCity: SpinnerCity(
                text: selectedCity,
                modal: modal,
                onCitySelected: (String city) {
                  if (selectedCity != city) {
                    setState(() {
                      selectedCity = city;
                    });
                  }
                })),
      ),
      RaisedButton(
        child: Text("clic"),
        onPressed: () => getWeatherData(selectedCity),
      ),
      SlidingDrawer(
        openableController: openableController,
        drawer: WeekDrawer(
          onDaySelected: (String title) {
            setState(() {
              selectedDay = title;
            });

            slidingController.close().then((_) => slidingController.open());

            openableController.close();
          },
        ),
      )
    ]));
  }
}
