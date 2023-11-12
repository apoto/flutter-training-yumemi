//ignore_for_file: sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class WeatherState {
  final String weatherCondition;
  final int maxTemperature;
  final int minTemperature;
  final bool isLoading;
  final String? errorMessage;
  final bool isErrorDialogShown;

  const WeatherState({
    this.weatherCondition = '',
    this.maxTemperature = 0,
    this.minTemperature = 0,
    this.isLoading = false,
    this.errorMessage,
    this.isErrorDialogShown = false,
  });

  WeatherState copyWith({
    String? weatherCondition,
    int? maxTemperature,
    int? minTemperature,
    bool? isLoading,
    String? errorMessage,
    bool? isErrorDialogShown,
  }) {
    return WeatherState(
      weatherCondition: weatherCondition ?? this.weatherCondition,
      maxTemperature: maxTemperature ?? this.maxTemperature,
      minTemperature: minTemperature ?? this.minTemperature,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isErrorDialogShown: isErrorDialogShown ?? this.isErrorDialogShown,
    );
  }
}
