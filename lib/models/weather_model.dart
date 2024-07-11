class Weather {
  final String cityName; // Name of the city
  final double temperature; // Temperature in the city
  final String mainCondition; // Main weather condition (e.g., clear, rain)

  // Constructor for the Weather class, with required named parameters
  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
  });

  // Factory constructor to create a Weather instance from JSON data
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'], // Extracting the city name from JSON
      temperature: json['main']['temp'].toDouble(), // Extracting and converting the temperature to double
      mainCondition: json['weather'][0]['main'], // Extracting the main weather condition from JSON
    );
  }
}
