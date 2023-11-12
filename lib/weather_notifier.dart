import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/json/weather_request.dart';
import 'package:flutter_training/json/weather_response.dart';
import 'package:flutter_training/weather_state.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherNotifier extends StateNotifier<WeatherState> {
  WeatherNotifier() : super(const WeatherState());

  Future<void> getWeather(String area, String date) async {
    state = state.copyWith(
      isLoading: true,
    );
    try {
      final requestString = WeatherRequest(area: area, date: date);
      final requestJsonString = jsonEncode(requestString.toJson());
      final responseJsonString =
          YumemiWeather().fetchWeather(requestJsonString);
      final responseJson =
          jsonDecode(responseJsonString) as Map<String, dynamic>;
      final weatherCondition = WeatherResponse.fromJson(responseJson);
      state = state.copyWith(
        weatherCondition: weatherCondition.weatherCondition,
        maxTemperature: weatherCondition.maxTemperature,
        minTemperature: weatherCondition.minTemperature,
        isLoading: false,
      );
    } on YumemiWeatherError catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  // void clearErrorMessage() {
  //   state = state.copyWith(
  //     errorMessage: null,
  //     isErrorDialogShown: false,
  //   );
  // }
}

final weatherProvider = StateNotifierProvider<WeatherNotifier, WeatherState>(
  (ref) => WeatherNotifier(),
);
