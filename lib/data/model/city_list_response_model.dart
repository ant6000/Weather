class CityListModel {
  int? id;
  String? name;
  String? region;
  String? country;
  double? lat;
  double? lon;
  String? url;
  CityListModel(
      {this.id,
      this.name,
      this.region,
      this.country,
      this.lat,
      this.lon,
      this.url});

  // CityListModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['name'];
  //   region = json['region'];
  //   country = json['country'];
  //   lat = json['lat'];
  //   lon = json['lon'];
  //   url = json['url'];
  // }

  factory CityListModel.fromJson(Map<String, dynamic> json) {
    return CityListModel(
      id: json['id'] as int,
      name: json['name'] as String,
      region: json['region'] as String,
      country: json['country'] as String,
      lat: json['lat'] as double,
      lon: json['lon'] as double,
      url: json['url'] as String,
    );
  }
}