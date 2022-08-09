import 'package:flutter/material.dart';
import 'package:learn_api/weather/weather_modals.dart';
import 'package:learn_api/weather/weather_servise.dart';

class TestWeatherApi extends StatefulWidget {
  TestWeatherApi({Key? key}) : super(key: key);

  @override
  State<TestWeatherApi> createState() => _TestWeatherApiState();
}

class _TestWeatherApiState extends State<TestWeatherApi> {
  final cityController = TextEditingController();
  final weatherService = WeatherService();

  //late WeatherResponse _response;   //Lateinitialization error failed has not been initialized. Solved by removing late and adding null check(?)
  WeatherResponse? _response;
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(_response != null)
              Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("City Name: ${_response?.cityName}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  Text("City Code: ${_response?.cityId}", style: const TextStyle(fontSize: 16,),),
                  Text("Temperature: ${_response?.tempResponse.temperature}°", style: const TextStyle(fontSize: 16,),),
                  Text("Description: ${_response?.weatherInfo.description}", style: const TextStyle(fontSize: 16,),),
                ],
              ),
              
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: SizedBox(
                width: 200,
                child: TextField(
                  controller: cityController,
                  decoration: const InputDecoration(
                    labelText: "City Name"
                  ),

                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                search();
              },
              child: const Text("Search")
            )
          ],
        ),
      ),
    );
  }

  void search() async{
    final response = await weatherService.getWeather(cityController.text);
    setState(() {
      _response = response;
    });
    // print(response.cityName + " " + response.cityId.toString());
    // print(response.tempResponse.temperature);
    // print(response.weatherInfo.icon + " " + response.weatherInfo.description);
  }
}