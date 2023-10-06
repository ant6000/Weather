import 'package:flutter/material.dart';
import 'package:http/http.dart';

class RemoteRepo {
  // this method is for getting real time weather update
  static Future<Response?> getRealtimeWeatherData(
      double lat, double lon) async {
    try {
      final url = Uri.parse(
          'https://weatherapi-com.p.rapidapi.com/current.json?q=$lat,$lon');
      Map<String, String> header = {
        'X-RapidAPI-Key': 'a2b133090bmsh71717a3b54feb8ap153d28jsncba845fef55e',
        'X-RapidAPI-Host': 'weatherapi-com.p.rapidapi.com'
      };

      final response = await get(url, headers: header);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // this method is for getting houlrly weather forcast
  static Future<Response?> getHourlyWeatherForcast(
      double lat, double lon, int days) async {
    try {
      final url = Uri.parse(
          'https://weatherapi-com.p.rapidapi.com/forecast.json?q=$lat,$lon&days=$days');
      Map<String, String> header = {
        'X-RapidAPI-Key': 'a2b133090bmsh71717a3b54feb8ap153d28jsncba845fef55e',
        'X-RapidAPI-Host': 'weatherapi-com.p.rapidapi.com'
      };
      final response = await get(url, headers: header);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // this method is for getting city list
  static Future<Response?> getCityList(String city) async {
    try {
      final url = Uri.parse(
          'https://weatherapi-com.p.rapidapi.com/search.json?q=$city');
      Map<String, String> header = {
        'X-RapidAPI-Key': 'a2b133090bmsh71717a3b54feb8ap153d28jsncba845fef55e',
        'X-RapidAPI-Host': 'weatherapi-com.p.rapidapi.com'
      };
      final response = await get(url, headers: header);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // static Future<List<City>> getCityLists(String cityName) async {
  //   try {
  //     final encodedCityName = Uri.encodeQueryComponent(cityName);
  //     final url = Uri.parse(
  //         'https://weatherapi-com.p.rapidapi.com/search.json?q=$encodedCityName');
  //     Map<String, String> headers = {
  //       'X-RapidAPI-Key': 'a2b133090bmsh71717a3b54feb8ap153d28jsncba845fef55e',
  //       'X-RapidAPI-Host': 'weatherapi-com.p.rapidapi.com'
  //     };

  //     final response = await get(url, headers: headers);
  //     //print(response.body);

  //     if (response.statusCode == 200) {
  //       final List<dynamic> cityData = json.decode(response.body);
  //       final List<City> cities =
  //           cityData.map((data) => City.fromJson(data)).toList();
  //       return cities;
  //     } else {
  //       // Handle non-200 status codes here
  //       debugPrint(
  //           'API request failed with status code: ${response.statusCode}');
  //       return [];
  //     }
  //   } catch (e) {
  //     debugPrint('API request failed with error: $e');
  //     return [];
  //   }
  // }
}
