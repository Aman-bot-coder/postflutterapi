import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {
  // late Map<String,dynamic> data={};
  List<dynamic> userData=[];
  Future getData() async{
    var url = Uri.parse("https://reqres.in/api/users?page=2");
    var response = await http.get(url);
    // var  data = jsonDecode(response.body);
    final body = response.body;
    final Json = jsonDecode(body);
    setState(() {
      userData = Json["data"];
    });

    print(userData.toString());
  }
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users List"),
      ),
      body: ListView.builder(
        itemCount:  userData.length,
        itemBuilder: (BuildContext context , int index){
          return Card(
            child: Column(
              children: [
                Row(
                  children: <Widget>[

                      CircleAvatar(
                        backgroundImage: NetworkImage(userData[index]["avatar"]),
                      ),
                    SizedBox(width: 5,),
                    Text(userData[index]["first_name"]),
                    SizedBox(width: 5,),
                    Text(userData[index]["last_name"])

                  ],

                ),
                // SizedBox(height: 4,),
                // Text(userData[index]["email"])
              ],
            )
            ,
          );
        },
      ),

    );
  }
}
