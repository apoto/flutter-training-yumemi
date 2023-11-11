//ignore_for_file: sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  @JsonKey(name: 'weather_condition')
  final String weatherCondition;
  @JsonKey(name: 'max_temperature')
  final int maxTemperature;
  @JsonKey(name: 'min_temperature')
  final int minTemperature;
  final String date;

  WeatherResponse({
    required this.weatherCondition,
    required this.maxTemperature,
    required this.minTemperature,
    required this.date,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}
