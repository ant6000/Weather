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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(time.toString(), style:  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05)),
        Icon(icon,size: 30),
        Text('$chanceOfRain %',style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),),
        Text('${temp.toString()}°', style:  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05)),
        const SizedBox(width: 100),
      ],
    );
  }
}
