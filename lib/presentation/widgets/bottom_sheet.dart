// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:weather/controller/hourly_forcast_provider.dart';
// import 'package:weather/controller/realtime_provider.dart';
// import 'package:weather/presentation/widgets/daily_forcast.dart';
// import 'package:weather/presentation/widgets/grid_tile.dart';
// import 'package:weather/presentation/widgets/hourly_forcast.dart';

// class BottomSheet extends StatelessWidget {
//   BottomSheet({super.key});
//   var time = DateTime.now().hour;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.topCenter,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 40),
//           child: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [Colors.blue, Colors.white]),
//             ),
//             child: SingleChildScrollView(
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Consumer2<RealtimeProvider, HourlyForcastProvider>(
//                       builder: (context, realtimeProvider,
//                           hourlyForcastprovider, _) {
//                     if (realtimeProvider.isLoading ||
//                         realtimeProvider.responseModel == null ||
//                         hourlyForcastprovider.responseModel == null) {
//                       return const CircularProgressIndicator();
//                     } else {
//                       return Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           const SizedBox(height: 10),
//                           Text(
//                             realtimeProvider.responseModel!.location!.name
//                                 .toString(),
//                             style: const TextStyle(fontSize: 30),
//                           ),
//                           Text(
//                               '${realtimeProvider.responseModel!.current!.tempC.toString()}°C',
//                               style: const TextStyle(fontSize: 50)),
//                           Text(
//                               realtimeProvider
//                                   .responseModel!.current!.condition!.text
//                                   .toString(),
//                               style: const TextStyle(fontSize: 20)),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                   'H:${hourlyForcastprovider.responseModel!.forecast!.forecastday![0].day!.maxtempC}°',
//                                   style: const TextStyle(fontSize: 20)),
//                               const SizedBox(width: 5),
//                               Text(
//                                   'L:${hourlyForcastprovider.responseModel!.forecast!.forecastday![0].day!.mintempC}',
//                                   style: const TextStyle(fontSize: 20)),
//                             ],
//                           ),
//                           const SizedBox(height: 20),
//                           Container(
//                             height: 200,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color: Colors.black26,
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 10, right: 10, top: 5),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     'Cloudy conditions rain expected arround 5PM',
//                                     style: TextStyle(fontSize: 20),
//                                   ),
//                                   const Divider(),
//                                   Expanded(
//                                     child: ListView.builder(
//                                       itemCount: 26,
//                                       shrinkWrap: true,
//                                       scrollDirection: Axis.horizontal,
//                                       itemBuilder: (context, index) {
//                                         final formattedHour = DateFormat('h')
//                                             .format(time.add(
//                                                 Duration(hours: index - 12)));
//                                         return HourlyForcast(
//                                             time: '${formattedHour}PM ',
//                                             temp: hourlyForcastprovider
//                                                     .responseModel
//                                                     ?.forecast
//                                                     ?.forecastday?[0]
//                                                     .hour?[int.parse(
//                                                         formattedHour)]
//                                                     .tempC ??
//                                                 0.0,
//                                             chanceOfRain: hourlyForcastprovider
//                                                     .responseModel
//                                                     ?.forecast
//                                                     ?.forecastday?[0]
//                                                     .hour?[int.parse(
//                                                         formattedHour)]
//                                                     .cloud ??
//                                                 0,
//                                             icon: Icons.cloud);
//                                       },
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                           Container(
//                             height: 200,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color: Colors.black26,
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 10, right: 10, top: 5),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Row(
//                                     children: [
//                                       Icon(Icons.calendar_month),
//                                       Text(
//                                         '3-DAY FORCAST',
//                                         style: TextStyle(fontSize: 20),
//                                       ),
//                                     ],
//                                   ),
//                                   const Divider(),
//                                   Expanded(
//                                     child: ListView.builder(
//                                       itemCount: hourlyForcastprovider
//                                           .responseModel
//                                           ?.forecast
//                                           ?.forecastday
//                                           ?.length,
//                                       shrinkWrap: true,
//                                       scrollDirection: Axis.vertical,
//                                       itemBuilder: (context, index) {
//                                         DateTime currentday =
//                                             time.add(Duration(days: index));
//                                         var nextDay = DateFormat('EEE')
//                                             .format(currentday);
//                                         return ThreeDaysForcast(
//                                           days: nextDay,
//                                           minTemp: hourlyForcastprovider
//                                                   .responseModel
//                                                   ?.forecast
//                                                   ?.forecastday?[index]
//                                                   .day
//                                                   ?.mintempC ??
//                                               0.0,
//                                           maxTemp: hourlyForcastprovider
//                                                   .responseModel
//                                                   ?.forecast
//                                                   ?.forecastday?[index]
//                                                   .day
//                                                   ?.maxtempC ??
//                                               0.0,
//                                           chanceOfRain: 50,
//                                         );
//                                       },
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                           GridView(
//                             shrinkWrap: true,
//                             scrollDirection: Axis.vertical,
//                             gridDelegate:
//                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 2,
//                                     childAspectRatio: 1,
//                                     crossAxisSpacing: 10,
//                                     mainAxisSpacing: 10),
//                             children: [
//                               Tile(
//                                   icon: Icons.wb_twilight,
//                                   title: 'SUNRISE',
//                                   data:
//                                       '${hourlyForcastprovider.responseModel!.forecast!.forecastday![0].astro!.sunrise}',
//                                   bottomText:
//                                       'Sunset: ${hourlyForcastprovider.responseModel!.forecast!.forecastday![0].astro!.sunset}'),
//                               Tile(
//                                   icon: Icons.remove_red_eye,
//                                   title: 'VISIBILITY',
//                                   data:
//                                       '${hourlyForcastprovider.responseModel!.current!.visKm}Km',
//                                   bottomText: 'Haze is affecting visibilty'),
//                               Tile(
//                                   icon: Icons.thermostat,
//                                   title: 'FEELS LIKE',
//                                   data:
//                                       '${hourlyForcastprovider.responseModel!.current!.feelslikeC}°C',
//                                   bottomText: 'Humidity is making it hotter'),
//                               Tile(
//                                   icon: Icons.water_drop_outlined,
//                                   title: 'HUMIDITY',
//                                   data:
//                                       '${hourlyForcastprovider.responseModel!.current!.humidity}%',
//                                   bottomText: 'The dew point is 24 right now'),
//                               Tile(
//                                   icon: Icons.water_drop,
//                                   title: 'RAINFALL',
//                                   data:
//                                       '${realtimeProvider.responseModel!.current!.precipMm}mm',
//                                   bottomText: '2mm expected in next 24h'),
//                               Tile(
//                                   icon: Icons.air,
//                                   title: 'WIND',
//                                   data:
//                                       '${realtimeProvider.responseModel!.current!.windKph} kph',
//                                   bottomText: ''),
//                             ],
//                           ),
//                           const SizedBox(height: 20),
//                           Text(
//                             'Weather for ${realtimeProvider.responseModel!.location!.name.toString()} ${realtimeProvider.responseModel!.location!.region.toString()},${realtimeProvider.responseModel!.location!.country.toString()}',
//                             style: const TextStyle(fontSize: 20),
//                           ),
//                           const SizedBox(height: 10),
//                         ],
//                       );
//                     }
//                   }),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               TextButton(onPressed: () {}, child: const Text('Cancle')),
//               TextButton(onPressed: () {}, child: const Text('Add')),
//             ],
//           ),
//         ),
//       ],
//     );;
//   }
// }