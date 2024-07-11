import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather'; // Base URL for OpenWeatherMap API
  final String apiKey; // API key for accessing the weather service

  WeatherService(this.apiKey); // Constructor to initialize the service with the API key

  // Method to get weather data for a given city name
  Future<Weather> getWeather(String cityName) async {

    // Making an HTTP GET request to fetch weather data
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

    if(response.statusCode == 200){
      return Weather.fromJson(jsonDecode(response.body)); // If the request is successful, parse and return the weather data
    }
    else {
      throw Exception('Failed to load weather data'); // If the request fails, throw an exception
    }
  }

  // Method to get the current city name based on the user's location
  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission(); // Check location permission
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission(); // Request location permission if denied
    }

    // Get the current position with high accuracy
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // Reverse geocode the coordinates to get placemarks
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks[0].locality; // Extract the city name from the placemarks

    // If city is null, return blank space
    return city ?? "";
  }
}
