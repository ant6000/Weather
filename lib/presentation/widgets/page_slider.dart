// import 'package:flutter/material.dart';

// class ImageSlider extends StatefulWidget {
//   const ImageSlider({super.key});

//   @override
//   ImageSliderState createState() => ImageSliderState();
// }

// class ImageSliderState extends State<ImageSlider> {
//   final List<Widget> widgets = [

//   ];

//   int _currentIndex = 0;

//   void _onPageChanged(int index) {

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 300,
//           child: PageView.builder(
//             itemCount: widgets.length,
//             itemBuilder: (context, index) {
//               return 
//             },
//             onPageChanged: _onPageChanged,
//           ),
//         ),
//         const SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: images.map((image) {
//             int index = images.indexOf(image);
//             return Container(
//               width: 10,
//               height: 10,
//               margin: const EdgeInsets.symmetric(horizontal: 4),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: _currentIndex == index ? Colors.blue : Colors.grey,
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }