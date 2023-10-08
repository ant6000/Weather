
class SavedTile {
  String cityName;
  String condition;
  double temp;
  double tempH, tempL;

  SavedTile(
      {required this.cityName,
      required this.condition,
      required this.temp,
      required this.tempH,
      required this.tempL});

  factory SavedTile.fromJson(Map<String, dynamic> json) {
    return SavedTile(
        cityName: json['name'] as String,
        condition: json['condition'] as String,
        temp: json['temp'] as double,
        tempH: json['maxtemp_c'] as double,
        tempL: json['mintemp_c'] as double);
  }
}
