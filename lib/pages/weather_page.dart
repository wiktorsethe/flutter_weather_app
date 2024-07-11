import 'package:flutter/material.dart';
import 'package:flutter_weather_app/services/weather_service.dart';
import 'package:lottie/lottie.dart';
import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key}); // Constructor for WeatherPage

  @override
  State<WeatherPage> createState() => _WeatherPageState(); // Creating the state for WeatherPage
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('500a5f4aacec85c02dd22fc2d547ab89'); // Instance of WeatherService with API key
  Weather? _weather; // Variable to store weather data

  // Method to fetch weather data
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity(); // Get the current city name

    try {
      final weather = await _weatherService.getWeather(cityName); // Fetch weather data for the city
      setState(() {
        _weather = weather; // Update the weather data in the state
      });
    } catch (e) {
      print(e); // Print the error if any
    }
  }

  // Method to get the appropriate weather animation based on the main weather condition
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json'; // Default animation if condition is null

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json'; // Return cloud animation for these conditions
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json'; // Return rain animation for these conditions
      case 'thunderstorm':
        return 'assets/thunder.json'; // Return thunderstorm animation
      case 'clear':
        return 'assets/sunny.json'; // Return sunny animation for clear condition
      default:
        return 'assets/sunny.json'; // Default animation for any other condition
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather(); // Fetch weather data when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? 'loading city...'), // Display city name or loading message
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)), // Display weather animation
            Text('${_weather?.temperature.round()}°C'), // Display temperature
            Text(_weather?.mainCondition ?? "") // Display main weather condition
          ],
        ),
      ),
    );
  }
}
