import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_api/weather_ui/weather_modals.dart';
import 'package:learn_api/weather_ui/weather_servise.dart';

class NewWeatherApp extends StatefulWidget {
  const NewWeatherApp({Key? key}) : super(key: key);

  @override
  State<NewWeatherApp> createState() => _NewWeatherAppState();
}

  DateTime now = DateTime.now();
  String convertedDateTime = "${now.year.toString()}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')} ${now.hour.toString().padLeft(2,'0')}-${now.minute.toString().padLeft(2,'0')}";    // to print only date and time get it from stackoverflow

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
            return SafeArea(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.only(top: 0),
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/image-4.jpeg",),
                        )
                      ),
                      child: Container(
                          margin: const EdgeInsets.only(left: 20, top: 22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton.icon(
                                onPressed: (){}, 
                                icon: const Icon(Icons.location_on, color: Colors.white, size: 22,), 
                                label: Text("${weatherData!.cityName}", 
                                style: GoogleFonts.actor(
                                  textStyle: const TextStyle(color:Colors.white, fontSize: 22)
                                ))
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  convertedDateTime,
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)
                                  )
                                ),
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
                                        Image.network(weatherData!.iconUrl, width: 70,),
                                        Text(weatherData!.weatherInfo.description.toUpperCase(), style: GoogleFonts.actor(textStyle: const TextStyle(color: Colors.white, fontSize: 15)))
                                      ],
                                    ),
                                    Text("${weatherData?.temp?.toStringAsFixed(0)}°", style: GoogleFonts.adamina(
                                      textStyle: TextStyle(color:Colors.white, fontSize: 42)
                                    ) )
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
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0), 
                          )
                        ),
                        builder: (BuildContext context) {
                          return Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25)
                              )
                            ),
                            height: 200,
                            child: Center(
                              child: Column(
                                children: [
                                  const SizedBox(height: 20,),
                                  Text('Weather Today', style: GoogleFonts.andika(
                                    textStyle: const TextStyle(fontSize:18, fontWeight: FontWeight.bold)
                                  ),),
                                  const SizedBox(height: 20,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        RecentWeather(icon: Icons.sunny, time: "Present", temp: "${weatherData!.temp?.toStringAsFixed(0)}°",),
                                        RecentWeather(icon: Icons.sunny_snowing, time: "Feels Like", temp: "${weatherData!.feels_like?.toStringAsFixed(0)}°",),
                                        RecentWeather(icon: Icons.sunny, time: "Min Temp", temp: "${weatherData!.temp_min?.toStringAsFixed(0)}°",),
                                        RecentWeather(icon: Icons.wb_sunny_rounded, time: "Max Temp", temp: "${weatherData!.temp_max?.toStringAsFixed(0)}°",),
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
                      icon: const Icon(Icons.menu, size: 36,),
                      color: Color(0xFFF8F8F8)),
                    ),
                  ),
                ],
              ),
            );

          }else{
            return const Text("data");
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
        Icon(icon, size: 40, color: Colors.yellow[700],),
        const SizedBox(height: 10,),
        Text(time, style: GoogleFonts.aBeeZee(
          textStyle: const TextStyle(color: Colors.grey, fontSize: 14))
        ),
        const SizedBox(height: 10,),
        Text(temp, style: GoogleFonts.anonymousPro(
          textStyle: const TextStyle(color: Colors.black, fontSize: 26)
        )),
      ],
    );
  }
}