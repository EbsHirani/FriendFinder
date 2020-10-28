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
  ChangeNotifier notifier;
  ChatScreen({
    this.uid,
    this.notifier
  });
  @override
  ChatScreenState createState() {
    return new ChatScreenState(uid : uid, notifier: notifier);
  }
}

class ChatScreenState extends State<ChatScreen> {
  String uid;
  bool load = true;
  Map map;
  List li;
  ChangeNotifier notifier;
  ChatScreenState(
    {this.uid,
    this.notifier}
  );

  void initState(){
    super.initState();
    notifier.addListener(() { 
      setState((){
        load = true;
      });
    });
  }

  Future<bool> getUsers() async {
    if(load){
    load = false;
    print("in chats");
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
    li = jsonDecode(res.body);
    
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
      body: FutureBuilder(
        future: getUsers(),
        builder: (context, snapshot) {
          if(snapshot.hasData){

          return new ListView.builder(
            itemCount: li.length,
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
                                likings : li[i]["user_profile"]["interest"],
                                 location: "Mumbai",
                                  friendsCount: 10,
                                   desc: li[i]["user_profile"]["bio"]),
                          uid: uid,
                          friendId: li[i]["user_id"],
                          name: li[i]["name"],
                          avatarTag: 'imageHero',
                          friendStatus: "Message",
                        ))).then((value) {
                  notifier.notifyListeners();
                  });
                      },
                      child: new ListTile(
                        leading: new CachedNetworkImage(
                            imageUrl:li[i]["user_profile"]["profile_picture"] == null ? 
                      "https://miro.medium.com/max/945/1*ilC2Aqp5sZd1wi0CopD1Hw.png":
                      li[i]["user_profile"]["profile_picture"],
                            progressIndicatorBuilder: (context, url, downloadProgress) => 
                                    CircularProgressIndicator(value: downloadProgress.progress),
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
                            li[i]["user_profile"]["bio"],
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