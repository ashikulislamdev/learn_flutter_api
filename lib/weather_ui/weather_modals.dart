class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({
    required this.description,
    required this.icon,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(description: description, icon: icon);
  }
}

class NewWeatherModel {
  final String? cityName;
  final double? temp;
  final double? feels_like;
  final double? temp_min;
  final double? temp_max;
  final WeatherInfo weatherInfo;
  NewWeatherModel({
    this.cityName,
    this.temp,
    this.feels_like,
    this.temp_min,
    this.temp_max,
    required this.weatherInfo,
  });


      // "feels_like":36.76,
      // "temp_min":31.25,
      // "temp_max":31.25,
  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  factory NewWeatherModel.fromJson(Map<String, dynamic> json){
    final weatherInfo = WeatherInfo.fromJson(json['weather'][0]);

    return NewWeatherModel(
      cityName: json['name'],
      temp: json['main']['temp'], 
      weatherInfo: weatherInfo,
      feels_like: json['main']['feels_like'],
      temp_min: json['main']['temp_min'],
      temp_max: json['main']['temp_max'],
      
    );
  }
}

/*
{
   "coord":{
      "lon":90.4074,
      "lat":23.7104
   },
   "weather":[
      {
         "id":803,
         "main":"Clouds",
         "description":"broken clouds",
         "icon":"04d"
      }
   ],
   "base":"stations",
   "main":{
      "temp":31.25,
      "feels_like":36.76,
      "temp_min":31.25,
      "temp_max":31.25,
      "pressure":1002,
      "humidity":65,
      "sea_level":1002,
      "grnd_level":1000
   },
   "visibility":10000,
   "wind":{
      "speed":3.2,
      "deg":156,
      "gust":3.35
   },
   "clouds":{
      "all":69
   },
   "dt":1660278260,
   "sys":{
      "country":"BD",
      "sunrise":1660260757,
      "sunset":1660307670
   },
   "timezone":21600,
   "id":1185241,
   "name":"Dhaka",
   "cod":200
}

*/