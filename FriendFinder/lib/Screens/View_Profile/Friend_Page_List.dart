import 'package:FriendFinder/Screens/ChatMessage/chat.dart';
import 'package:FriendFinder/Screens/Status/status_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:FriendFinder/models/chat_model.dart';

class FriendsListScreen extends StatefulWidget {
  @override
  FriendsListScreenState createState() {
    return new FriendsListScreenState();
  }
}

class FriendsListScreenState extends State<FriendsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friend List"),
        elevation: 0.7,
      ),
      body: new ListView.builder(
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
      ),
    );
  }
}
