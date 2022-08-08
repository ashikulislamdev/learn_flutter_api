class WeatherResponse {
  final String cityName;
  final int cityId;
  WeatherResponse({     //generate constrictor
    required this.cityName,
    required this.cityId,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> getJsonData){    // json is a collection of map/dictionary
    final cityName = getJsonData['name'];    //add the key name which define in the api
    final cityId = getJsonData['id'];
    return WeatherResponse(cityName: cityName, cityId: cityId);
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
         "id":721,
         "main":"Haze",
         "description":"haze",
         "icon":"50d"
      }
   ],
   "base":"stations",
   "main":{
      "temp":307.14,
      "feels_like":314.14,
      "temp_min":307.14,
      "temp_max":307.14,
      "pressure":997,
      "humidity":59
   },
   "visibility":4000,
   "wind":{
      "speed":5.14,
      "deg":140
   },
   "clouds":{
      "all":75
   },
   "dt":1659953842,
   "sys":{
      "type":1,
      "id":9145,
      "country":"BD",
      "sunrise":1659915055,
      "sunset":1659962237
   },
   "timezone":21600,
   "id":1185241,
   "name":"Dhaka",
   "cod":200
}

*/