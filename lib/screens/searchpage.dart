import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_provider.dart';
import 'package:provider/provider.dart';

class Searchpage extends StatefulWidget {
  final PageController pageController;
  const Searchpage({super.key, required this.pageController});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  final SearchController _searchController = SearchController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(16, 60, 16, 16),
        child: Column(
          children: [
            SearchBar(
              autoFocus: false,
              keyboardType: TextInputType.text,
              controller: _searchController,
              hintText: 'Enter the City',
              onSubmitted: (value) async {
                try {
                  ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Fetching Data...')));
                  await Provider.of<WeatherProvider>(context, listen: false)
                      .getWeatherData(value);
                  widget.pageController.jumpToPage(0);
                } catch (e) {
                  debugPrint('Error: $e');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Error : $e'),
                  ));
                }
              },
              leading: const Icon(Icons.search),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () async {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Fetching Data...')));
                await Provider.of<WeatherProvider>(context, listen: false)
                    .fetchCity();
                widget.pageController.jumpToPage(0);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_pin),
                  Text('Use my location'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
