// ignore_for_file: public_member_api_docs, sort_constructors_first
class Weather {
  int id;
  String city;
  double temp;
  String desc;
  String humidity;
  double feels_like;
  String wind_speed;
  String pressure;

  Weather({
    required this.id,
    required this.city,
    required this.temp,
    required this.desc,
    required this.humidity,
    required this.feels_like,
    required this.wind_speed,
    required this.pressure,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    // notifyListeners();
    return Weather(
        id: json['weather'][0]['id'].toInt(),
        city: json['name'],
        desc: json['weather'][0]['main'],
        temp: json['main']['temp'].toDouble(),
        humidity: json['main']['humidity'].toString(),
        pressure: json['main']['pressure'].toString(),
        feels_like: json['main']['feels_like'],
        wind_speed: json['wind']['speed'].toString()
        );
  }
}
