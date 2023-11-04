import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
  });

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String _weather = '';

  void getWeather() {
    final yumemiWeather = YumemiWeather();
    final weatherCondition = yumemiWeather.fetchSimpleWeather();
    print('Weather Condition: $weatherCondition'); // "sunny"
    setState(() {
      _weather = weatherCondition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                              onPressed: () {},
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
      ),
    );
  }
}
