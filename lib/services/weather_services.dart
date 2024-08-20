// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/constants/constants.dart';

import 'package:weather_app/models/weather_model.dart';

class WeatherService {

  static Future<Weather> getWeatherByCity(String city) async {
    final response = await http.get(
      Uri.parse('$baseUrl?q=$city&appid=$API_KEY'),
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body.toString()));
    } else {
      throw Exception("Unable to load data");
    }
  }

  static Future<String> getLocationCity() async {
    //check permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission= await Geolocator.requestPermission();
    }

    //if permission is allowed
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> place =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    return place[0].locality ?? "";
  }
}
