//ignore_for_file: sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'weather_request.g.dart';

@JsonSerializable()
class WeatherRequest {
  final String area;
  final String date;

  WeatherRequest({
    required this.area,
    required this.date,
  });

  factory WeatherRequest.fromJson(Map<String, dynamic> json) =>
      _$WeatherRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherRequestToJson(this);
}
