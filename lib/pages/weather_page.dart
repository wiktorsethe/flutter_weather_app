import 'package:flutter/material.dart';
import 'package:flutter_weather_app/services/weather_service.dart';
import 'package:lottie/lottie.dart';

import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  final _weatherService = WeatherService('500a5f4aacec85c02dd22fc2d547ab89');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    catch(e){
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if(mainCondition == null) return 'assets/sunny.json';

    switch(mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';

    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? 'loading city...'),
            
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            
            Text('${_weather?.temperature.round()}°C'),
            
            Text(_weather?.mainCondition ?? "")
          ],
        ),
      ),
    );
  }
}
