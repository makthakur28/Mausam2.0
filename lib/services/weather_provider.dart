import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  static String _city = 'Loading City';
  static Weather? _weatherdata;

  WeatherProvider() {
    fetchCity();
  }

  String get city => _city;
  get weatherdata => _weatherdata;

  void setCity(city) {
    _city = city;
    notifyListeners();
  }

  getWeatherData(city) async {
    try {
      final data = await WeatherService.getWeatherByCity(city);
      debugPrint('${data.id}\n${data.city}\n${data.temp}\n${data.desc}');
      debugPrint(data.toString());
      // setState(() {
      _weatherdata = data;
      _city = data.city;
      // });
    } catch (e) {
      debugPrint("Some error in fetching data : $e");
    }
    notifyListeners();
  }

  Future<void> fetchCity() async {
    final city = await WeatherService.getLocationCity();
    debugPrint(city);
    getWeatherData(city);
  }
}
