import 'package:flutter/material.dart';

class ThreeDaysForcast extends StatelessWidget {
  final String days;
  final dynamic minTemp;
  final dynamic maxTemp;
  final dynamic chanceOfRain;
  const ThreeDaysForcast(
      {super.key,
      required this.days,
      required this.minTemp,
      required this.maxTemp,
      required this.chanceOfRain});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
            width: 50,
            child: Text(days.trim(), style: const TextStyle(fontSize: 20))),
        const SizedBox(width: 30),
        Column(
          children: [
            const Icon(Icons.cloud),
            Text(
              '$chanceOfRain %',
              style: const TextStyle(fontSize: 10),
            )
          ],
        ),
        const SizedBox(width: 10),
        Text('$minTemp °', style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 5),
        Container(
          height: 10,
          width: 150,
          color: Colors.red,
        ),
        const SizedBox(width: 5),
        Text('$maxTemp °', style: const TextStyle(fontSize: 20)),
      ],
    );
  }
}
