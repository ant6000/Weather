import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/controller/city_list_provider.dart';
import 'package:weather/controller/hourly_forcast_provider.dart';
import 'package:weather/presentation/widgets/details_page.dart';
import 'package:weather/presentation/widgets/saved_location_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
      // RealtimeProvider realtimeProvider =
      //     Provider.of<RealtimeProvider>(context, listen: false);
      // CityListProvider cityListProvider =
      //     Provider.of<CityListProvider>(context, listen: false);
      // for (var element in cityListProvider.getCityList) {
      //   realtimeProvider.callRealTimeForcastApi(element.name.toString());
      // }
      // realtimeProvider.callRealTimeForcastApi(lat, lon);
    });
  }

  final cityNameInputController = TextEditingController();
  var time = DateTime.now().hour;

  @override
  Widget build(BuildContext context) {
    return Consumer2<CityListProvider, HourlyForcastProvider>(
        builder: (context, cityListProvider, forcastProvider, _) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: const [
            Icon(Icons.settings_rounded),
            SizedBox(width: 20),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Weather',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: cityNameInputController,
                  onChanged: (value) {
                    cityListProvider.callCityListApi(value);
                    if (value.isEmpty) {
                      cityListProvider.getCityList.clear();
                    }
                    cityListProvider.getCityList.length > 1;
                    cityListProvider.savedLocatonListVisible = false;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search for a city or airport',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(20),
                            left: Radius.circular(20))),
                  ),
                ),
                const SizedBox(height: 20),
                /////////////////////////////////////////////////////////////////////////
                // this container will show city list after give input in the text field
                ///////////////////////////////////////////////////////////////////////
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView.builder(
                    itemCount: cityListProvider.getCityList.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          textColor: Colors.white,
                          hoverColor: Colors.green,
                          tileColor: Colors.black,
                          title: Text(
                              '${cityListProvider.getCityList[index].name.toString()} ${cityListProvider.getCityList[index].region.toString()} ${cityListProvider.getCityList[index].country.toString()}'),
                          onTap: () {
                            cityListProvider.index = index;
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              isScrollControlled: true,
                              useSafeArea: true,
                              context: context,
                              builder: (context) {
                                return showbottomsheet(cityListProvider);
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                ///////////////////////////////////////////////////
                // this list view will show saved city list tile
                //////////////////////////////////////////////////
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cityListProvider.showlist(),
                  itemBuilder: (context, index) {
                    return SavedLocation(
                      index: index,
                      cityName:
                          '${cityListProvider.getSavedLocation[index].name}',
                      condition:
                          '${forcastProvider.responseModel!.current!.condition!.text}',
                      temp: '${forcastProvider.responseModel!.current!.tempC}',
                      tempH:
                          '${forcastProvider.responseModel!.forecast!.forecastday![0].day!.maxtempC}',
                      tempL:
                          '${forcastProvider.responseModel!.forecast!.forecastday![0].day!.mintempC}',
                      time:
                          '${forcastProvider.responseModel!.location!.localtime}',
                    );
                  },
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget showbottomsheet(CityListProvider cityListProvider) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 40),
          child: DisplayWeatherData(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    cityListProvider.getCityList.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Cancle')),
              TextButton(
                  onPressed: () {
                    cityListProvider.addToSavedList();
                    cityListProvider.getCityList.clear();
                    cityNameInputController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Add')),
            ],
          ),
        ),
      ],
    );
  }
}
