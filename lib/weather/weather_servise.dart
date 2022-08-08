import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:learn_api/weather/weather_modals.dart';

class WeatherService{
  Future<WeatherResponse> getWeather(String city) async {   //we entered WeatherResponse as a future
    // https://api.openweathermap.org/data/2.5/weather?id={city id}&appid={API key}   key = "12739d1299e1b3aaceec8073306eb294"

    final queryParam = {'q': city,'appid':'12739d1299e1b3aaceec8073306eb294'};  //diclured this param as api calling by city doc

    final uri = Uri.https('api.openweathermap.org', '/data/2.5/weather', queryParam); //pass the url and path as url.https doc

    final response = await http.get(uri);   //rui bind with http package(use await keyword for load the data)

    //print(response.body);
    final getJsonData = jsonDecode(response.body);    //decoding the json data

    return WeatherResponse.fromJson(getJsonData);   //return the json object

  }
}