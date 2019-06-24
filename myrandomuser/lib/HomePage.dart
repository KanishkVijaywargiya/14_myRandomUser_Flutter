import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List usersData;
  bool isLoading = true;
  final String url = "https://randomuser.me/api/?results=50";

  Future<String> getData() async {
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept": "application/json"}
    );
    List data = jsonDecode(response.body)['results'];
    setState(() {
      usersData = data;
      isLoading = false;
    });
  }

  @override
  void initState() { 
    super.initState();
    this.getData();  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random Users"),
      ),
      body: Container(
        child: Center(
          child: isLoading ? CircularProgressIndicator() : ListView.builder(
            itemCount: usersData == null ? 0 : usersData.length,
            itemBuilder: (BuildContext context, int index){
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: Image(
                        width: 70.0,
                        height: 70.0,
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          usersData[index]['picture']['thumbnail'],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Name: ${usersData[index]['name']['first'] + " " +
                            usersData[index]['name']['last']}",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "Gender: ${usersData[index]['gender']}",
                            style: TextStyle(
                              fontSize: 10.0,
                            ),
                          ),
                          Text(
                            "Cell: ${usersData[index]['phone']}",
                            Icon(
                              Icons.phone
                            ),
                            style: TextStyle(
                              fontSize: 10.0,
                            ),
                          ),
                          Text(
                            "D.O.B: ${usersData[index]['dob']['date']}" "\n"
                            "Age: ${usersData[index]['dob']['age']}",
                          ),
                          Text(
                            "Email: ${usersData[index]['email']}",
                            style: TextStyle(
                              fontFamily: 'Cute Font',
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}