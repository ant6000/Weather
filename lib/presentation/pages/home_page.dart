import 'package:flutter/material.dart';
import 'package:weather/presentation/widgets/details_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/homePage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather',style: TextStyle(color: Colors.white),),
      centerTitle: true,
      backgroundColor: Colors.blueAccent,
      ),
      body: const DisplayWeatherData(),
      
    );
  }
}
