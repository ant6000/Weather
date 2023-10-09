import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/controller/city_list_provider.dart';
import 'package:weather/controller/hourly_forcast_provider.dart';
import 'package:weather/controller/realtime_provider.dart';
import 'package:weather/presentation/widgets/three_days_forcast.dart';
import 'package:weather/presentation/widgets/grid_tile.dart';
import 'package:weather/presentation/widgets/hourly_forcast.dart';

class DisplayWeatherData extends StatefulWidget {
  const DisplayWeatherData({super.key});

  @override
  State<DisplayWeatherData> createState() => _DisplayWeatherDataState();
}

class _DisplayWeatherDataState extends State<DisplayWeatherData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      RealtimeProvider realtimeProvider =
          Provider.of<RealtimeProvider>(context, listen: false);
      HourlyForcastProvider hourlyForcastProvider =
          Provider.of<HourlyForcastProvider>(context, listen: false);
      CityListProvider cityListProvider =
          Provider.of<CityListProvider>(context, listen: false);

      if (cityListProvider.getCityList.isEmpty) {
        String city = cityListProvider
            .getSavedLocation[cityListProvider.index].location!.name
            .toString();
        realtimeProvider.callRealTimeForcastApi(city);
        hourlyForcastProvider.callHourlyForcastApi(city);
      } else {
        String city = cityListProvider.getCityList[cityListProvider.index].name
            .toString();
        realtimeProvider.callRealTimeForcastApi(city);
        hourlyForcastProvider.callHourlyForcastApi(city);
      }
    });
    super.initState();
  }

  List<String> getNext24Hours() {
    final currentTime = DateTime.now();
    final formatter = DateFormat('h a');
    final List<String> hoursList = [];

    for (int i = 0; i < 24; i++) {
      final nextHour = currentTime.add(Duration(hours: i));
      final formattedHour = formatter.format(nextHour);
      hoursList.add(formattedHour);
    }
    return hoursList;
  }

  final List<Gradient> bgColors = [
    const LinearGradient(
      colors: [Colors.black, Colors.yellow],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Colors.red, Colors.blue],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Colors.purple, Colors.white],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var time = DateTime.now();
    return Consumer2<RealtimeProvider, HourlyForcastProvider>(
        builder: (context, realtimeProvider, hourlyForcastprovider, _) {
      if (realtimeProvider.isLoading ||
          realtimeProvider.responseModel == null ||
          hourlyForcastprovider.responseModel == null) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue, Colors.white])
                // image: DecorationImage(
                //     image: AssetImage('images/clouds.gif'), fit: BoxFit.cover),
                ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    /////////////////////////////////////////////////
                    //this block if for show header data like temp loc maxtemp mintemp
                    ///////////////////////////////////////////////////
                    Text(
                      realtimeProvider.responseModel!.location!.name.toString(),
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.1),
                    ),
                    Text(
                        '${realtimeProvider.responseModel!.current!.tempC.toString()}°C',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.1)),
                    Text(
                        realtimeProvider.responseModel!.current!.condition!.text
                            .toString(),
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width * 0.08)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            'H:${hourlyForcastprovider.responseModel!.forecast!.forecastday![0].day!.maxtempC}°',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05)),
                        const SizedBox(width: 5),
                        Text(
                            'L:${hourlyForcastprovider.responseModel!.forecast!.forecastday![0].day!.mintempC}',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ////////////////////////////////////////////
                    ///this container for hourly frocast update
                    ///////////////////////////////////////////
                    Container(
                      height: MediaQuery.of(context).size.width * 0.6,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black26,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: [
                            Text(
                              'Cloudy conditions rain expected around 5PM',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              child: ListView.builder(
                                itemCount:
                                    24, // Change this to 24 to include all 24 hours
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final formattedHour = getNext24Hours()[
                                      index]; // Get individual hour
                                  final parsedTime =
                                      DateFormat('h a').parse(formattedHour);
                                  final hour = parsedTime
                                      .hour; // This will give you the hour component as an integer (0-23)
                                  double? hourlyWeather;
                                  double? chancesOfRain;
                                  if (formattedHour == '12 AM' && index > 0) {
                                    hourlyWeather = hourlyForcastprovider
                                        .responseModel
                                        ?.forecast
                                        ?.forecastday?[1]
                                        .hour?[hour]
                                        .tempC;
                                    chancesOfRain = hourlyForcastprovider
                                            .responseModel
                                            ?.forecast
                                            ?.forecastday?[1]
                                            .hour?[hour]
                                            .cloud;
                                  } else {
                                    hourlyWeather = hourlyForcastprovider
                                        .responseModel
                                        ?.forecast
                                        ?.forecastday?[0]
                                        .hour?[hour]
                                        .tempC;
                                    chancesOfRain = hourlyForcastprovider
                                            .responseModel
                                            ?.forecast
                                            ?.forecastday?[0]
                                            .hour?[hour]
                                            .chanceOfRain;
                                  }
                                  return HourlyForcast(
                                    time: formattedHour,
                                    temp: hourlyWeather ?? 0.0,
                                    chanceOfRain: chancesOfRain ?? 0.0,
                                    icon: Icons.thunderstorm_rounded,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    //////////////////////////////////////////////////
                    /// this container block for show 3 days forcasts
                    ////////////////////////////////////////////////
                    Container(
                      height: MediaQuery.of(context).size.width * 0.5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black26,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.calendar_month),
                                Text(
                                  '3-DAY FORCAST',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                ),
                              ],
                            ),
                            const Divider(),
                            Expanded(
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: hourlyForcastprovider.responseModel
                                    ?.forecast?.forecastday?.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  DateTime currentday =
                                      time.add(Duration(days: index));
                                  var nextDay =
                                      DateFormat('EEE').format(currentday);
                                  return ThreeDaysForcast(
                                    days: nextDay,
                                    minTemp: hourlyForcastprovider
                                            .responseModel
                                            ?.forecast
                                            ?.forecastday?[index]
                                            .day
                                            ?.mintempC ??
                                        0.0,
                                    maxTemp: hourlyForcastprovider
                                            .responseModel
                                            ?.forecast
                                            ?.forecastday?[index]
                                            .day
                                            ?.maxtempC ??
                                        0.0,
                                    chanceOfRain: hourlyForcastprovider
                                        .responseModel
                                        ?.forecast
                                        ?.forecastday?[index]
                                        .day
                                        ?.dailyChanceOfRain,
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ////////////////////////////////////////////
                    // this gridview is for show grid tiles info
                    ////////////////////////////////////////////
                    GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      children: [
                        Tile(
                            icon: Icons.wb_twilight,
                            title: 'SUNRISE',
                            data:
                                '${hourlyForcastprovider.responseModel!.forecast!.forecastday![0].astro!.sunrise}',
                            bottomText:
                                'Sunset: ${hourlyForcastprovider.responseModel!.forecast!.forecastday![0].astro!.sunset}'),
                        Tile(
                            icon: Icons.remove_red_eye,
                            title: 'VISIBILITY',
                            data:
                                '${hourlyForcastprovider.responseModel!.current!.visKm}Km',
                            bottomText: 'Haze is affecting visibilty'),
                        Tile(
                            icon: Icons.thermostat,
                            title: 'FEELS LIKE',
                            data:
                                '${hourlyForcastprovider.responseModel!.current!.feelslikeC}°C',
                            bottomText: 'Humidity is making it hotter'),
                        Tile(
                            icon: Icons.water_drop_outlined,
                            title: 'HUMIDITY',
                            data:
                                '${hourlyForcastprovider.responseModel!.current!.humidity}%',
                            bottomText: 'The dew point is 24 right now'),
                        Tile(
                            icon: Icons.water_drop,
                            title: 'RAINFALL',
                            data:
                                '${realtimeProvider.responseModel!.current!.precipMm}mm',
                            bottomText: '2mm expected in next 24h'),
                        Tile(
                            icon: Icons.air,
                            title: 'WIND',
                            data:
                                '${realtimeProvider.responseModel!.current!.windKph} kph',
                            bottomText: ''),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Weather for ${realtimeProvider.responseModel!.location!.name.toString()} ${realtimeProvider.responseModel!.location!.region.toString()},${realtimeProvider.responseModel!.location!.country.toString()}',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    });
  }
}
