import 'dart:convert';

import 'package:friendfinder/Screens/User_Profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:friendfinder/models/chat_model.dart';
import 'package:http/http.dart' as http;

class RequestsPage extends StatefulWidget {
  String uid;
  RequestsPage({
    this.uid,
  });
  @override
  _RequestsPageState createState() => _RequestsPageState(uid : uid);
}

class _RequestsPageState extends State<RequestsPage> {
  String uid;
  List li;
  _RequestsPageState({
    this.uid
  });
  bool load = true;
  Future<bool> getUsers() async {
    print(uid);
    if(load){
    load = false;
    print("in req");
    http.Response res = await http.post(
      'http://192.168.0.110:5000/pending_request',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: 
        jsonEncode(<String,String>{
        "user_id": uid

        })
      
    );
    

    li = jsonDecode(res.body);
    print(li);
    
    
    
    // li = map.keys.toList();
    // print(li.keys);
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friend List"),
        elevation: 0.7,
      ),
      body: FutureBuilder(
        future: getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData){

          return new ListView.builder(
            itemCount: li.length,
            itemBuilder: (context, i) => new Column(
              children: <Widget>[
                new Divider(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserProfile()));
                  },
                  child: new ListTile(
                    leading: new CachedNetworkImage(
                      imageUrl: li[i]["user_profile"]["profile_picture"] == null ? 
                      "https://miro.medium.com/max/945/1*ilC2Aqp5sZd1wi0CopD1Hw.png":
                      li[i]["user_profile"]["profile_picture"],
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          CircularProgressIndicator(
                              value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    title: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          li[i]["user_profile"]["name"],
                          style: new TextStyle(fontWeight: FontWeight.bold),
                        ),
                        new Text(
                          dummyData[i].time,
                          style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                        ),
                      ],
                    ),
                    subtitle: new Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: new Text(
                        // ignore: todo
                        li[i]["user_profile"]["bio"], //TODO : Status here
                        style: new TextStyle(color: Colors.grey, fontSize: 15.0),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
          }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        }
      ),
    );
  }
}