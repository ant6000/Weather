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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.thunderstorm_rounded,size: 30),
            Text(
              '$chanceOfRain %',
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
            )
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('$minTemp °',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04)),
              Container(
                height: 10,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red,
                ),
              ),
              Text('$maxTemp °',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04)),
            ],
          ),
        ),
        //const SizedBox(height: 10),
      ],
    );
  }
}
