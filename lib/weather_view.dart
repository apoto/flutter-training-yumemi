import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

  void getWeather() {
    try {
      final weatherCondition = YumemiWeather().fetchThrowsWeather('tokyo');
      if (!mounted) {
        return;
      }
      setState(() {
        _weather = weatherCondition;
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
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '** ℃',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blue),
                        ),
                        Text(
                          '** ℃',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red),
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
