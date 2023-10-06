import 'package:flutter/material.dart';

class SavedLocation extends StatelessWidget {
  final String cityNmae;
  final String time;
  final String condition;
  final dynamic temp;
  final dynamic tempH;
  final dynamic tempL;
  const SavedLocation(
      {required this.cityNmae,
      required this.time,
      required this.condition,
      required this.temp,
      required this.tempH,
      required this.tempL,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/detailsPage');
        },
        child: Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blueAccent),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 70,
                      child: Column(
                        children: [
                          Text(cityNmae, style: const TextStyle(fontSize: 25)),
                          Text(time, style: const TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),
                    Text(condition, style: const TextStyle(fontSize: 20))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$temp°C', style: const TextStyle(fontSize: 40)),
                    Row(
                      children: [
                        Text('H: $tempH°',
                            style: const TextStyle(fontSize: 15)),
                        Text('L: $tempL°', style: const TextStyle(fontSize: 15))
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
