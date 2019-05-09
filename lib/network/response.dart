import 'package:json_annotation/json_annotation.dart';
import '../forecast/Weather.dart';

part 'response.g.dart';

@JsonSerializable()
class BaseResponse extends Object with _$BaseResponseSerializerMixin{
  final double message;
  final String cod;
  final int cnt;

  @JsonKey(name: "list")
  final List<History> history;

  BaseResponse({
    this.message,
    this.cod,
    this.cnt,
    this.history
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);
}

@JsonSerializable()
class History extends Object with _$HistorySerializerMixin {
  final int dt;
  final Main main;
  final List<Weather> weather;
  final Clouds clouds;
  @JsonKey(name: "dt_txt")
  final String dtTxt;

  History({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.dtTxt
  });
  factory History.fromJson(Map<String, dynamic> json) => _$HistoryFromJson(json);
}

@JsonSerializable()
class Main extends Object with _$MainSerializerMixin{
  final double temp;
  @JsonKey(name: "temp_min")
  final double tempMin;
  @JsonKey(name: "temp_max")
  final double tempMax;
  final double pressure;
  @JsonKey(name: "sea_level")
  final double seaLevel;
  @JsonKey(name: "grnd_level")
  final double grndLevel;
  final double humidity;
  @JsonKey(name: "temp_kf")
  final double tempKf;

  Main({
    this.temp,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf
  });

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);
}

@JsonSerializable()
class Clouds extends Object with _$CloudsSerializerMixin{
  final int all;

  Clouds({
    this.all
  });

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);
}