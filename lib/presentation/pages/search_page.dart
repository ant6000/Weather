import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/controller/city_list_provider.dart';
import 'package:weather/controller/hourly_forcast_provider.dart';
import 'package:weather/presentation/widgets/details_page.dart';
import 'package:weather/presentation/widgets/saved_location_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  static const String routeName = '/searchPage';
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool flag = true;
  @override
  void initState() {
    super.initState();
    print('here');
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
      load();
    });
  }

  load() {
   // flag = false;
    final hourlyForcastProvider =
        Provider.of<HourlyForcastProvider>(context, listen: false);
    final cityListProvider =
        Provider.of<CityListProvider>(context, listen: false);
    if (flag == true) {
      print('object');
      //cityListProvider.writeToSharedPref();
      cityListProvider.readFromSharedPref(hourlyForcastProvider);
      flag = false;
    }
  }

  final cityNameInputController = TextEditingController();
  var time = DateTime.now().hour;

  @override
  Widget build(BuildContext context) {
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
        child: Consumer2<CityListProvider, HourlyForcastProvider>(
            builder: (context, cityListProvider, forcastProvider, _) {
          return SingleChildScrollView(
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
                                return showbottomsheet(
                                    cityListProvider, forcastProvider, index);
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
                      temp: cityListProvider
                          .getSavedLocation[index].current!.tempC,
                      cityName: cityListProvider
                          .getSavedLocation[index].location!.name
                          .toString(),
                      condition: cityListProvider
                          .getSavedLocation[index].current!.condition!.text
                          .toString(),
                      tempH: cityListProvider.getSavedLocation[index].forecast!
                          .forecastday![0].day!.maxtempC,
                      tempL: cityListProvider.getSavedLocation[index].forecast!
                          .forecastday![0].day!.mintempC,
                      time: cityListProvider
                          .getSavedLocation[index].location!.localtime
                          .toString(),
                    );
                  },
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget showbottomsheet(CityListProvider cityListProvider,
      HourlyForcastProvider hourlyForcastProvider, int index) {
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
                    cityListProvider
                        .addToSavedList(hourlyForcastProvider.responseModel);
                        cityListProvider.writeToSharedPref(cityListProvider.getCityList[index].name.toString());
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
