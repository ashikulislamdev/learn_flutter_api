import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 12),
        child: ListView.builder(
          itemCount: listOfResponse == null ? 0 : listOfResponse.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(listOfResponse[index]['first_name']+" "+listOfResponse[index]['last_name']),
              subtitle: Text(listOfResponse[index]['email']),
              leading: Image.network(listOfResponse[index]['avatar']),
              trailing: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.amber[600],
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Center(child: Text(listOfResponse[index]['id'].toString())),
              ),
            );
          }
        ),
      ),
    );
  }
}
