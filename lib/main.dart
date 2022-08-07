import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TestingApi()
    );
  }
}

late String stringResponse;
late Map mapResponse;
late Map dataResponse;

late List listOfResponse;

class TestingApi extends StatefulWidget {
  const TestingApi({Key? key}) : super(key: key);
  
  @override
  State<TestingApi> createState() => _TestingApiState();
}

class _TestingApiState extends State<TestingApi> {
  
  Future callApi() async{
    http.Response response;   //make a http variable
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));  //parse the url to the var

    if (response.statusCode == 200) {   //check the statusCode is 200
      setState(() {
        stringResponse = response.body;   //if 200 is okay then we store our data in a local variable
        mapResponse = json.decode(stringResponse);  //get all the data json format so i've convert it 
        //dataResponse = mapResponse['data'];  //get all the data json format so i've convert it 
        listOfResponse = mapResponse['data'];  //get all the data json format so i've convert it 
      });
    }
  }

  @override
  void initState() {  // 
    super.initState();
    callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width - 30,
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.lightBlue
          ),
          // child: Center(
          //   child: dataResponse == null ? const Text("Loading....")
          //   : Text(dataResponse['email'].toString()),
          // ),
          child: Center(
            child: listOfResponse == null ? const Text("Loading....")
            : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Hello I'm " + listOfResponse[1]['first_name'].toString() +" "+ listOfResponse[1]['last_name'].toString()),
                Image.network(listOfResponse[1]['avatar'].toString(),),
                Text(listOfResponse[1]['email'].toString() + " is my Email id")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
