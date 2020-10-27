import 'dart:convert';

import 'package:friendfinder/Screens/ChatMessage/chat.dart';
import 'package:friendfinder/Screens/Status/status_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:friendfinder/Screens/View_Profile/friends/friend.dart';
import 'package:friendfinder/models/chat_model.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  String uid;
  ChatScreen({
    this.uid
  });
  @override
  ChatScreenState createState() {
    return new ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {
  String uid;
  bool load = true;
  Map map;
  List li;

  Future<bool> getUsers() async {
    if(load){
    load = false;
    print("in");
    http.Response res = await http.get(
      'http://192.168.0.110:5000/get_all_users',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    map = jsonDecode(res.body);
    li = map.keys.toList();
    // print(li.keys);
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friend Finder"),
        elevation: 0.7, ),
      body: new ListView.builder(
        itemCount: dummyData.length,
        itemBuilder: (context, i) => new Column(
              children: <Widget>[
                new Divider(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPageView(
                      friend: Friend(avatar: li[i]["user_profile"]["profile_picture"] == null? 
                          "https://miro.medium.com/max/945/1*ilC2Aqp5sZd1wi0CopD1Hw.png":
                          li[i]["user_profile"]["profile_picture"],
                           name: li[i]["user_profile"]["name"],
                            email: li[i]["user_profile"]["email"],
                             location: "Mumbai",
                              friendsCount: 10,
                               desc: li[i]["user_profile"]["bio"]),
                      uid: "NrZIV7Lqo1dLrFvQLZnzrPJhn8N2",
                      friendId: "bMxLnAalZfgfUyLrIyrzsrH91eD3",
                      name: "varun",
                      avatarTag: 'imageHero',
                      friendStatus: "Message",
                    )));
                  },
                  child: new ListTile(
                    leading: new CachedNetworkImage(
                        imageUrl: dummyData[i].avatarUrl,
                        progressIndicatorBuilder: (context, url, downloadProgress) => 
                                CircularProgressIndicator(value: downloadProgress.progress),
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
                        dummyData[i].message,
                        style: new TextStyle(color: Colors.grey, fontSize: 15.0),
                      ),
                    ),
                  ),
                )
              ],
            ),
      ),
    );
  }
}