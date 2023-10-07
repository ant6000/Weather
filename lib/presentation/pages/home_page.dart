import 'package:flutter/material.dart';
import 'package:weather/presentation/widgets/details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const DisplayWeatherData(),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/searchPage');
              },
              child: const Icon(Icons.list),
            )
          ],
        ),
      ),
    );
  }
}
