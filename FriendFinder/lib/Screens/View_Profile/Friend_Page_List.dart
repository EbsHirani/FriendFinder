import 'dart:convert';

import 'package:friendfinder/Screens/ChatMessage/chat.dart';
import 'package:friendfinder/Screens/Status/status_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:friendfinder/models/chat_model.dart';
import 'package:http/http.dart' as http;

class FriendsListScreen extends StatefulWidget {
  String uid;
  FriendsListScreen({
    this.uid,
  });
  
  @override
  FriendsListScreenState createState() {
    return new FriendsListScreenState(uid : uid);
  }
}

class FriendsListScreenState extends State<FriendsListScreen> {
  String uid;
  Map map;
  List li;
  FriendsListScreenState({this.uid});
  bool load = true;
  Future<bool> getUsers() async {
    print(uid);
    if(load){
    load = false;
    print("in");
    http.Response res = await http.post(
      'http://192.168.0.110:5000/get_all_friends',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: 
        jsonEncode(<String,String>{
        "user_id": uid

        })
      
    );
    try{

      var x = jsonDecode(res.body);
      print(x);
    }
    catch(e){
      print(e);
    }
    
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
          return new ListView.builder(
            itemCount: dummyData.length,
            itemBuilder: (context, i) => new Column(
              children: <Widget>[
                new Divider(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChatPageView()));
                  },
                  child: new ListTile(
                    leading: new CachedNetworkImage(
                      imageUrl: dummyData[i].avatarUrl,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          CircularProgressIndicator(
                              value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    title: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          dummyData[i].name,
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
                        dummyData[i].message, //TODO : Status here
                        style: new TextStyle(color: Colors.grey, fontSize: 15.0),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
