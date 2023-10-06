import 'package:flutter/material.dart';

class HourlyForcast extends StatelessWidget {
  final String time;
  final dynamic temp;
  final dynamic chanceOfRain;
  final IconData icon;
  const HourlyForcast({super.key, required this.time, required this.temp, required this.chanceOfRain, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(time.toString(), style: const TextStyle(fontSize: 20)),
        Icon(icon),
        Text('$chanceOfRain %',style:const TextStyle(fontSize: 15),),
        Text('${temp.toString()}°', style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 70),
      ],
    );
  }
}
