import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather/data/model/forcast_response_model.dart';
import 'package:weather/data/repository/remote_repo.dart';

class HourlyForcastProvider extends ChangeNotifier {
  HourlyForcastModel? responseModel;
  bool _isloading = false;
  bool get isLoading => _isloading;

  void callHourlyForcastApi(String city) async {
    _isloading = true;
    notifyListeners();
    final response = await RemoteRepo.getHourlyWeatherForcast(city, 3);
    if (response!.statusCode == 200) {
      var data = json.decode(response.body);
      responseModel = HourlyForcastModel.fromJson(data);
      _isloading = false;
      notifyListeners();
    } else {
      _isloading = false;
      notifyListeners();
    }
  }
}
