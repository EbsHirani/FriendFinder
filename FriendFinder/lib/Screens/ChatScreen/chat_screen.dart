import 'package:friendfinder/Screens/ChatMessage/chat.dart';
import 'package:friendfinder/Screens/Status/status_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:friendfinder/models/chat_model.dart';

class ChatScreen extends StatefulWidget {
  @override
  ChatScreenState createState() {
    return new ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {
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
                      uid: "NrZIV7Lqo1dLrFvQLZnzrPJhn8N2",
                      friendId: "bMxLnAalZfgfUyLrIyrzsrH91eD3",
                      name: "varun"
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