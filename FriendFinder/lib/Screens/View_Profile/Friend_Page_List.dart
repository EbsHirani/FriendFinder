import 'dart:convert';

import 'package:friendfinder/Screens/ChatMessage/chat.dart';
import 'package:friendfinder/Screens/Status/status_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:friendfinder/Screens/View_Profile/friend_details_page.dart';
import 'package:friendfinder/models/chat_model.dart';
import 'package:http/http.dart' as http;

import 'friends/friend.dart';

class FriendsListScreen extends StatefulWidget {
  String uid;
  ChangeNotifier notifier;
  FriendsListScreen({
    this.notifier,
    this.uid,
  });
  
  @override
  FriendsListScreenState createState() {
    return new FriendsListScreenState(uid : uid, notifier:notifier);
  }
}

class FriendsListScreenState extends State<FriendsListScreen> {
  String uid;
  Map map;
  List li;
  ChangeNotifier notifier;
  FriendsListScreenState({this.uid, this.notifier});
  void initState(){
    super.initState();
    notifier.addListener(() { 
      setState((){
        load = true;
      });
    });
  }
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
    

    li = jsonDecode(res.body);
    // print(li);
    
    
    
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
          if(snapshot.hasData){

          return new ListView.builder(
            itemCount: li.length,
            itemBuilder: (context, i) =>
             new Column(
              children: <Widget>[
                new Divider(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FriendDetailsPage(
                          Friend(avatar: li[i]["user_profile"]["profile_picture"] == null? 
                          "https://miro.medium.com/max/945/1*ilC2Aqp5sZd1wi0CopD1Hw.png":
                          li[i]["user_profile"]["profile_picture"],
                           name: li[i]["user_profile"]["name"],
                            email: li[i]["user_profile"]["email"],
                            likings: li[i]["user_profile"]["interest"],
                             location: "Mumbai",
                              friendsCount: 10,
                               desc: li[i]["user_profile"]["bio"]),
                          uid : uid,
                            friend_uid: li[i]["user_id"],
                          avatarTag: 'imageHero',
                          friendStatus: "Message",
                        ))).then((value) {
                  notifier.notifyListeners();
                  });
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
                        // new Text(
                        //   dummyData[i].time,
                        //   style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                        // ),
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
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        }
      ),
    );
  }
}
