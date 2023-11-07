import 'package:flutter/material.dart';
import 'package:flutter_training/weather_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({
    super.key,
  });

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        //Navigator.push(context, WeatherView.route());
        Navigator.of(context).push(
          MaterialPageRoute<Widget>(
            builder: (context) => const WeatherView(),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
    );
  }
}
