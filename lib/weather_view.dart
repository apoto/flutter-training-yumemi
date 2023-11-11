import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_training/json/weather_request.dart';
import 'package:flutter_training/json/weather_response.dart';

import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({
    super.key,
  });

  @override
  State<WeatherView> createState() => _MainAppState();
}

class _MainAppState extends State<WeatherView> {
  String _weather = '';
  int _maxTemperature = 0;
  int _minTemperature = 0;

  void getWeather() {
    try {
      final requestString =
          WeatherRequest(area: 'tokyo', date: '2020-04-01T12:00:00+09:00');
      final requestJsonString = jsonEncode(requestString.toJson());
      final responseJsonString =
          YumemiWeather().fetchWeather(requestJsonString);
      final responseJson =
          jsonDecode(responseJsonString) as Map<String, dynamic>;

      if (!mounted) {
        return;
      }
      final weatherCondition = WeatherResponse.fromJson(responseJson);

      setState(() {
        _weather = weatherCondition.weatherCondition;
        _maxTemperature = weatherCondition.maxTemperature;
        _minTemperature = weatherCondition.minTemperature;
      });
    } on YumemiWeatherError catch (error) {
      if (!mounted) {
        return;
      }
      showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('仮のテキスト'),
            content: Text(error.toString()),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: _weather != ''
                        ? SvgPicture.asset('assets/$_weather.svg')
                        : const Placeholder(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '$_minTemperature ℃',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.blue),
                        ),
                        Text(
                          '$_maxTemperature ℃',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Close',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          TextButton(
                            onPressed: getWeather,
                            child: const Text(
                              'Reload',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
