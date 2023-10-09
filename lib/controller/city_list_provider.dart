import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/controller/hourly_forcast_provider.dart';
import 'package:weather/data/model/city_list_response_model.dart';
import 'package:weather/data/model/forcast_response_model.dart';
import 'package:weather/data/repository/remote_repo.dart';
import 'package:weather/presentation/widgets/saved_location_tile.dart';

class CityListProvider extends ChangeNotifier {
  CityListModel? cityListModel;
  HourlyForcastModel? responseModel;
  bool _isloading = false;
  bool get isLoading => _isloading;
  int index = -1;

  final List<CityListModel> _cityList = [];
  List<CityListModel> get getCityList => _cityList;

   List<HourlyForcastModel> _savedLocation = [];
  List<HourlyForcastModel> get getSavedLocation => _savedLocation;

  List<HourlyForcastModel> cityNames = [];

  bool savedLocatonListVisible = true;

  showlist() {
    if (getCityList.isEmpty) {
      return _savedLocation.length;
      //return cityNames.length;
    } else {
      return 0;
    }
  }

  void callCityListApi(String cityName) async {
    _isloading = true;
    _cityList.clear();
    notifyListeners();
    final response = await RemoteRepo.getCityList(cityName);
    if (response!.statusCode == 200) {
      var data = json.decode(response.body);
      if (data.toString() == "[]") {
        _isloading = false;
        notifyListeners();
      } else {
        final List<dynamic> citylists = data;
        citylists.forEach((element) {
          cityListModel = CityListModel.fromJson(element);
          _cityList.add(cityListModel!);
        });
        _isloading = false;
        notifyListeners();
      }
    } else {
      _isloading = false;
      notifyListeners();
    }
  }

  void addToSavedList(HourlyForcastModel? model) {
    if (model != null) {
      if (_savedLocation
          .any((element) => element.location!.name == model.location!.name)) {
        getCityList.clear();
        return;
      } else {
        _savedLocation.add(model);
        notifyListeners();
      }
    }
  }

  Future<void> writeToSharedPref(String cityName) async {
    final pref = await SharedPreferences.getInstance();
    List<String> tempCityList = [];
    final List<String> items = pref.getStringList('city')?? [];
    if(items.isEmpty){
    tempCityList.add(cityName);
    await pref.setStringList('city', tempCityList);
    }else{
      tempCityList = items;
      tempCityList.add(cityName);
      await pref.setStringList('city', tempCityList);
    }
  }

  Future<void> readFromSharedPref(
      HourlyForcastProvider hourlyForcastProvider) async {
    final pref = await SharedPreferences.getInstance();
    final List<String> items = pref.getStringList('city')?? [];
    print(items.length);
    for (var i = 0; i < items.length; i++) {
      final response = await RemoteRepo.getHourlyWeatherForcast(items[i], 1);
      if (response!.statusCode == 200) {
        var data = json.decode(response.body);
        responseModel = HourlyForcastModel.fromJson(data);
        _savedLocation.add(responseModel!);
        notifyListeners();
      }
    }
  }
}
