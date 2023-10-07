import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String data;
  final String bottomText;
  const Tile(
      {super.key,
      required this.icon,
      required this.title,
      required this.data,
      required this.bottomText});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black26),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 30,
                ),
                Text(title,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05)),
              ],
            ),
            Text(data,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.08)),
            Text(bottomText,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04)),
          ],
        ),
      ),
    );
  }
}
