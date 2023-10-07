import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather/data/model/city_list_response_model.dart';
import 'package:weather/data/repository/remote_repo.dart';

class CityListProvider extends ChangeNotifier {
  CityListModel? cityListModel;
  bool _isloading = false;
  bool get isLoading => _isloading;
  int index = -1;

  final List<CityListModel> _cityList = [];
  List<CityListModel> get getCityList => _cityList;

  final List<CityListModel> _savedLocation = [];
  List<CityListModel> get getSavedLocation => _savedLocation;

  bool savedLocatonListVisible = true;

  showlist() {
    if (getCityList.isEmpty) {
      return _savedLocation.length;
    } else {
      return 0;
    }
  }

  void addToSavedList() {
    _savedLocation.add(cityListModel!);
    print(cityListModel!.name);
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
}
