import 'package:flutter/material.dart';
import './forecast/weekdrawer.dart';
import './forecast/forecastappbar.dart';
import './widgets/sliding_drawer.dart';
import './forecast/forecast.dart';
import './forecast/forecast_list.dart';
import './forecast/sliding_radial_list.dart';
import './widgets/modal.dart';
import './widgets/spinner_city.dart';
import 'package:drizzle/network/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:drizzle/network/model/weather_repo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final WeatherRepo weatherRepo = new WeatherRepo(client: http.Client());
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drizzle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage()
      home: FutureBuilder<List<WeatherModel>>(
        future: weatherRepo.updateWeather("Yaoundé"),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return MyHomePage(data: weatherRepo.getWeatherData());
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Nous n'avons pas pu charger les données"),
            );
          }

          return Stack(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[CircularProgressIndicator()],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<WeatherModel> data;
  MyHomePage({this.data});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  OpenableController openableController;
  SlidingRadialListController slidingController;
  final week = [];
  final List days = new List();
  Modal modal;
  List<WeatherModel> data;

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

  @override
  void initState() {
    this._initData();
    super.initState();
    this.data = widget.data;
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
        data: data,
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
                    var wr = new WeatherRepo(client: http.Client())
                        .updateWeather(city);
                    wr.then((value) {
                      setState(() {
                        selectedCity = city;
                        data = value;
                      });
                    });
                  }
                })),
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
