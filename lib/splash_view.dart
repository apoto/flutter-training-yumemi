import 'package:flutter/material.dart';
import 'package:flutter_training/weather_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({
    super.key,
  });

  @override
  State<SplashView> createState() => _SplashViewState();
}

mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => afterLayout());
  }

  void afterLayout();
}

class _SplashViewState extends State<SplashView>
    with AfterLayoutMixin<SplashView> {
  @override
  void afterLayout() {
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
