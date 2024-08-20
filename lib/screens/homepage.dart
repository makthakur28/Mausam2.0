import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/weather_provider.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  final PageController pageController;
  const HomeScreen({super.key, required this.pageController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bool darkmode = false;
  // final date = DateTime(DateTime.april).month;
  DateTime d = DateTime.now();
  late int hour = d.hour;

  LottieBuilder? getAnimation(int id) {
    if (id >= 200 && id < 300) {
      return Lottie.asset('asset/lottie/Thunderstorm.json');
    }
    if (id >= 800) {
      return Lottie.asset('asset/lottie/cloudy.json');
    }
    if (id >= 500 && id < 600) {
      return Lottie.asset('asset/lottie/Rain.json');
    }
    return Lottie.asset('asset/lottie/sunny.json');
  }

  @override
  void initState() {
    super.initState();
    hour = d.hour;
  }

  int gethour(DateTime d) {
    return d.hour;
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    // Provider.of<WeatherProvider>(context).fetchCity();
    final data = Provider.of<WeatherProvider>(context).weatherdata;
    return Scaffold(
        body: data == null
            ? const Center(child: CircularProgressIndicator())
            : Container(
                height: h,
                // width: w,
                decoration: BoxDecoration(gradient: gradientbytime(hour)),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 50, 16, 16),
                  child: Column(
                    children: [
                      Consumer<WeatherProvider>(
                        builder: (BuildContext context, WeatherProvider value,
                            Widget? child) {
                          return Text(value.city,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        offset: Offset(1, 1),
                                        blurRadius: 30)
                                  ]));
                        },
                      ),
                      Text(DateFormat('yyyy-MM-dd hh:mm a').format(d),style: const TextStyle(color: Colors.white),),
                      SizedBox(
                          width: 180,
                          height: 180,
                          child: getAnimation(data?.id ?? 100)),
                      RichText(
                          text: TextSpan(
                              text: data.temp?.toString()[0] ?? "0",
                              style: const TextStyle(
                                  fontSize: 60,
                                  shadows: [
                                    Shadow(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        offset: Offset(1, 1),
                                        blurRadius: 15)
                                  ],
                                  fontWeight: FontWeight.bold),
                              children: [
                            TextSpan(
                                text: data.temp?.toString()[1] ?? "0",
                                style: const TextStyle(fontSize: 40)),
                            const TextSpan(
                                text: "°", style: TextStyle(fontSize: 40))
                          ])),
                      Text(
                        data.desc?.toString() ?? "description",
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'monospace',
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      weekForecastComponent(w, data)
                    ],
                  ),
                ),
              ));
  }

  Expanded weekForecastComponent(double w, data) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          list_item(w, 'Humidity', data?.humidity+' %' ?? "NA"),
          const SizedBox(
            height: 10,
          ),
          list_item(w, 'Pressure', data?.pressure+' hPa' ?? "NA"),
          const SizedBox(
            height: 10,
          ),
          list_item(w, 'Wind Speed', data?.wind_speed+' mph' ?? "NA"),
          const SizedBox(
            height: 10,
          ),
          list_item(w, 'Feels Like', (data?.feels_like-273).toStringAsFixed(1)+'°' ?? "NA"),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Row customAppBar() {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu,
              color:
                  gethour(DateTime.now()) > 18 ? Colors.white : Colors.black),
          style: const ButtonStyle(iconSize: WidgetStatePropertyAll(25)),
        ),
        const Text(
          "Mausam 2.0",
          style:
              TextStyle(fontSize: 25, color: Colors.white, fontFamily: "Arial"),
        )
      ],
    );
  }

  LinearGradient gradientbytime(int currHour) {
    if (currHour < 4) {
      return const LinearGradient(begin: Alignment.topLeft, colors: [
        Color.fromRGBO(89, 0, 255, 1),
        Color.fromARGB(255, 102, 0, 255),
        Color.fromARGB(255, 36, 76, 255)
      ]);
    }
    if (currHour < 12) {
      return const LinearGradient(begin: Alignment.topLeft, colors: [
        Colors.orange,
        Colors.yellow,
        Color.fromARGB(255, 255, 175, 54)
      ]);
    }
    if (currHour < 21) {
      return const LinearGradient(begin: Alignment.topLeft, colors: [
        Color.fromARGB(255, 21, 110, 193),
        Color.fromARGB(255, 65, 150, 255),
        Color.fromARGB(255, 113, 159, 208)
      ]);
    }
    return const LinearGradient(begin: Alignment.topLeft, colors: [
      Color.fromRGBO(89, 0, 255, 1),
      Color.fromARGB(255, 102, 0, 255),
      Color.fromARGB(255, 0, 25, 137)
    ]);
  }

  Padding list_item(double w, String key, String value) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          // SizedBox(width: 30,),
          Expanded(
              child: Text(key,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      // fontFamily: 'monospace',
                      shadows: [
                        Shadow(
                            color: Color.fromARGB(255, 187, 187, 187),
                            offset: Offset(1, 1),
                            blurRadius: 30)
                      ],
                      fontWeight: FontWeight.bold))),
          // Expanded(child: Align(alignment: Alignment.center, child: wid)),
          Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(value,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        shadows: [
                          Shadow(
                              color: Color.fromARGB(255, 0, 0, 0),
                              offset: Offset(1, 1),
                              blurRadius: 30)
                        ],
                        // fontFamily: 'monospace',
                        fontWeight: FontWeight.bold))),
          )
        ],
      ),
    );
  }
}
