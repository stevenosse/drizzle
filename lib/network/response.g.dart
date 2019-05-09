// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) {
  return new BaseResponse(
      message: (json['message'] as num)?.toDouble(),
      cod: json['cod'] as String,
      cnt: json['cnt'] as int,
      history: (json['list'] as List)
          ?.map((e) => e == null
              ? null
              : new History.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

abstract class _$BaseResponseSerializerMixin {
  double get message;
  String get cod;
  int get cnt;
  List<History> get history;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'message': message,
        'cod': cod,
        'cnt': cnt,
        'list': history
      };
}

History _$HistoryFromJson(Map<String, dynamic> json) {
  return new History(
      dt: json['dt'] as int,
      main: json['main'] == null
          ? null
          : new Main.fromJson(json['main'] as Map<String, dynamic>),
      weather: (json['weather'] as List)
          ?.map((e) => e == null
              ? null
              : new Weather.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      clouds: json['clouds'] == null
          ? null
          : new Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
      dtTxt: json['dt_txt'] as String);
}

abstract class _$HistorySerializerMixin {
  int get dt;
  Main get main;
  List<Weather> get weather;
  Clouds get clouds;
  String get dtTxt;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'dt': dt,
        'main': main,
        'weather': weather,
        'clouds': clouds,
        'dt_txt': dtTxt
      };
}

Main _$MainFromJson(Map<String, dynamic> json) {
  return new Main(
      temp: (json['temp'] as num)?.toDouble(),
      tempMin: (json['temp_min'] as num)?.toDouble(),
      tempMax: (json['temp_max'] as num)?.toDouble(),
      pressure: (json['pressure'] as num)?.toDouble(),
      seaLevel: (json['sea_level'] as num)?.toDouble(),
      grndLevel: (json['grnd_level'] as num)?.toDouble(),
      humidity: (json['humidity'] as num)?.toDouble(),
      tempKf: (json['temp_kf'] as num)?.toDouble());
}

abstract class _$MainSerializerMixin {
  double get temp;
  double get tempMin;
  double get tempMax;
  double get pressure;
  double get seaLevel;
  double get grndLevel;
  double get humidity;
  double get tempKf;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'temp': temp,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'sea_level': seaLevel,
        'grnd_level': grndLevel,
        'humidity': humidity,
        'temp_kf': tempKf
      };
}

Clouds _$CloudsFromJson(Map<String, dynamic> json) {
  return new Clouds(all: json['all'] as int);
}

abstract class _$CloudsSerializerMixin {
  int get all;
  Map<String, dynamic> toJson() => <String, dynamic>{'all': all};
}
