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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.15,
          child: Text(days.trim(),
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05)),
        ),
        const SizedBox(width: 30),
        Column(
          children: [
            const Icon(Icons.cloud),
            Text(
              '$chanceOfRain %',
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
            )
          ],
        ),
        const SizedBox(width: 10),
        Text('$minTemp °',
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04)),
        const SizedBox(width: 5),
        Container(
          height: 10,
          width: MediaQuery.of(context).size.width * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.red,
          ),
        ),
        const SizedBox(width: 5),
        Text('$maxTemp °',
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04)),
      ],
    );
  }
}
