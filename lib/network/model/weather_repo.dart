import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:drizzle/network/model/model.dart';
import 'package:drizzle/env.dart';
import 'package:drizzle/network/response.dart';

class WeatherRepo {
  final http.Client client;

  var weatherData;

  WeatherRepo({this.client});

  Future<List<WeatherModel>> updateWeather(city) async {
    final String url = Env.API_URL + "?q=" + city + "&appid=" + Env.MAP_API_KEY+"&cnt=5";
    var response = await client.get(url);

    if (response.statusCode == 200) {
      List<WeatherModel> req = BaseResponse
        .fromJson(json.decode(response.body))
        .history
        .map((h) => WeatherModel.fromResponse(h))
        .toList();

        weatherData = req;
      return req;
    } else {
      throw Exception('Failed to load post');
    }
  }

  List<WeatherModel> getWeatherData(){
    return this.weatherData;
  }  
}
