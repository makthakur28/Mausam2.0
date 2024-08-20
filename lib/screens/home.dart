import 'package:flutter/material.dart';
import 'package:weather_app/screens/homepage.dart';
import 'package:weather_app/screens/searchpage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var activePage = 0;
  final PageController _controller = PageController();

  void onTap(int index) {
    setState(() {
      activePage = index;
    });
    _controller.jumpToPage(index);
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
              // width: w,
              decoration: BoxDecoration(gradient: gradientbytime(DateTime.now().hour)),
        child: PageView(
        
          onPageChanged: (value) {
            setState(() {
              activePage = value;
            });
          },
          controller: _controller,
          children: [HomeScreen(pageController: _controller,), Searchpage(pageController: _controller,)],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
        ],
        currentIndex: activePage,
        onTap: (value) {
          onTap(value);
        },
        elevation: 10,
        fixedColor: Colors.blueAccent,
        backgroundColor: const Color.fromARGB(255, 203, 231, 255),
      ),
    );
  }
}
