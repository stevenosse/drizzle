import 'package:drizzle/network/response.dart';

class WeatherModel {
  final double temperature;
  final String description;
  final time;

  WeatherModel({
    this.temperature,
    this.description,
    this.time
  });

  WeatherModel.fromResponse(History response) 
    :
      temperature = response.main.temp,
      time = response.dtTxt,
      description = response.weather[0].description;
}