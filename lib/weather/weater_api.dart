import 'package:flutter/material.dart';
import 'package:learn_api/weather/weather_servise.dart';

class TestWeatherApi extends StatelessWidget {
  TestWeatherApi({Key? key}) : super(key: key);

  final cityController = TextEditingController();
  final weatherService = WeatherService();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
    print(response.cityName + " " + response.cityId.toString());
  }
}