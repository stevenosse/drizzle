import 'package:json_annotation/json_annotation.dart';

part 'Weather.g.dart';

@JsonSerializable()
class Weather extends Object with  _$WeatherSerializerMixin{
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon
  });
  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);
}