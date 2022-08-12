import 'package:flutter/material.dart';
import 'package:learn_api/weather_ui/weather_modals.dart';
import 'package:learn_api/weather_ui/weather_servise.dart';

class NewWeatherApp extends StatefulWidget {
  const NewWeatherApp({Key? key}) : super(key: key);

  @override
  State<NewWeatherApp> createState() => _NewWeatherAppState();
}

class _NewWeatherAppState extends State<NewWeatherApp> {
  
  NewWeatherService weatherService = NewWeatherService();
  NewWeatherModel? weatherData;

  Future<void> getWeather() async{
    weatherData = await weatherService.getWeather("Madina");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: FutureBuilder(
        future: getWeather(),
        builder: (context, snapshot) {
          if (weatherData != null) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.only(top: 0),
                    color: Colors.blue,
                    height: MediaQuery.of(context).size.height/2.5,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                        margin: const EdgeInsets.only(left: 20, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton.icon(
                              onPressed: (){}, 
                              icon: const Icon(Icons.location_on, color: Colors.white, size: 22,), 
                              label: Text("${weatherData!.cityName}", style: const TextStyle(color:Colors.white, fontSize: 16))
                            ),
                            const SizedBox(height: 6,),
                            const Text(
                              "Date and time",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 40,),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      //Icon(weatherData!.icon, size:30, color: Colors.white,),
                                      Image.network(weatherData!.iconUrl, width: 60,),
                                      Text(weatherData!.weatherInfo.description, style: TextStyle(color: Colors.white, ),)
                                    ],
                                  ),
                                  Text("${weatherData!.temp}°", style: TextStyle(color:Colors.white, fontSize: 36))
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                    onPressed: () {

                      showModalBottomSheet<void>(
                      context: context,                      
                      builder: (BuildContext context) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(25)
                            )
                          ),
                          height: 150,
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(height: 20,),
                                const Text('Weather Today', style: TextStyle(fontSize:15, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      RecentWeather(icon: Icons.sunny, time: "Present", temp: "${weatherData!.temp}°",),
                                      RecentWeather(icon: Icons.sunny_snowing, time: "Feels Like", temp: "${weatherData!.feels_like}°",),
                                      RecentWeather(icon: Icons.sunny, time: "Min Temp", temp: "${weatherData!.temp_min}°",),
                                      RecentWeather(icon: Icons.wb_sunny_rounded, time: "Max Temp", temp: "${weatherData!.temp_max}°",),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    );

                    },
                    icon: const Icon(Icons.menu),
                    color: const Color.fromARGB(255, 248, 248, 248)),
                  ),
                ),
                Positioned(
                  top: 235,
                  child: Image.asset("assets/images/image-2.jpeg", fit: BoxFit.fill, width: MediaQuery.of(context).size.width,)
                )
              ],
            );

          }else{
            return Text("data");
          }
        },
      )
      
    );
  }
  
}


class RecentWeather extends StatelessWidget {
  const RecentWeather({
    Key? key,
    required this.icon,
    required this.time,
    required this.temp,
  }) : super(key: key);
  
  final IconData icon;
  final String time;
  final String temp;

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Icon(icon, size: 32, color: Colors.yellow[700],),
        const SizedBox(height: 6,),
        Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12),),
        const SizedBox(height: 6,),
        Text(temp, style: const TextStyle(color: Colors.black, fontSize: 22),),
      ],
    );
  }
}