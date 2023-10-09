import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.amber,
              ),
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.black,
              ),
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.red,
              ),
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.brown,
              ),
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.blue,
              ),
              GridView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics:const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      color: Colors.black,
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      color: Colors.black,
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      color: Colors.black,
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      color: Colors.black,
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      color: Colors.black,
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      color: Colors.black,
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      color: Colors.black,
                    ),
                  ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
