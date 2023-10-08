import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather/data/model/realtime_response_model.dart';
import 'package:weather/data/repository/remote_repo.dart';

class RealtimeProvider extends ChangeNotifier {
  RealTimeResponseModel? _responseModel;
  RealTimeResponseModel? get responseModel=>_responseModel;


  bool _isloading = false;
  bool get isLoading => _isloading;

  void callRealTimeForcastApi(String city) async {
      _isloading = true;
      notifyListeners();
      final response = await RemoteRepo.getRealtimeWeatherData(city);
      if (response!.statusCode == 200) {
        var data = json.decode(response.body);
        _responseModel = RealTimeResponseModel.fromJson(data);
        _isloading = false;
        notifyListeners();
      } else {
        _isloading = false;
        notifyListeners();
      }
  }
}
