import 'dart:convert';

import 'package:friendfinder/Screens/Report/report.dart';
import 'package:flutter/material.dart';
import 'package:friendfinder/Screens/View_Profile/header/diagonally_cut_colored_image.dart';
import 'package:friendfinder/Screens/View_Profile/friends/friend.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;


class FriendDetailHeader extends StatefulWidget {
  static const BACKGROUND_IMAGE = 'assets/images/login_bottom.png';

  FriendDetailHeader(
    this.friend, {
      this.uid,
      this.friend_uid,
      this.friendStatus,
    @required this.avatarTag,
  });
  final String friendStatus, friend_uid, uid;
  final Friend friend;
  final Object avatarTag;

  @override
  _FriendDetailHeaderState createState() => _FriendDetailHeaderState(friendStatus: friendStatus, friend_uid: friend_uid, uid:uid);
}

class _FriendDetailHeaderState extends State<FriendDetailHeader> {
  var screenWidth;
  String friendStatus, friend_uid, uid;
  _FriendDetailHeaderState({this.friendStatus, this.friend_uid, this.uid});
  Widget _buildDiagonalImageBackground(BuildContext context) {

    return new DiagonallyCutColoredImage(
      new Image.asset(
        FriendDetailHeader.BACKGROUND_IMAGE,
        width: screenWidth,
        height: 280.0,
        fit: BoxFit.cover,
      ),
      color: const Color(0xBB8338f4),
    );
  }

  Widget _buildAvatar() {
    return new Hero(
      tag: widget.avatarTag,
      child: new CircleAvatar(
        backgroundImage: new NetworkImage(widget.friend.avatar),
        radius: 50.0,
      ),
    );
  }

  Widget _buildFollowerInfo(TextTheme textTheme) {
    var followerStyle =
        textTheme.subhead.copyWith(color: const Color(0xBBFFFFFF));

    return new Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text('90 Following', style: followerStyle),
          new Text(
            ' | ',
            style: followerStyle.copyWith(
                fontSize: 24.0, fontWeight: FontWeight.normal),
          ),
          new Text('100 Followers', style: followerStyle),
        ],
      ),
    );
  }

  Widget _buildActionButtons(ThemeData theme,var context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        friendStatus == "Message"?
        Row(
          children: [new Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                left: 16.0,
                right: 16.0,
              ),
              child: 
              _createPillButton(
                context,
                'UnFriend',
                backgroundColor: Colors.black,
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                left: 16.0,
                right: 16.0,
              ),
              child: 
              _createPillButton(
                context,
                'Report',
                backgroundColor: Colors.red
              ),
            ),
          ],
        ):Container(),
        new Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          child: friendStatus == "Add Friend" ? _createPillButton(
            context,
            'Add Friend',
            backgroundColor: theme.accentColor,
          )
          :
          friendStatus == "Request Sent"?
          _createPillButton(
            context,
            'Request Sent',
            backgroundColor: Colors.black,
          ):
          _createPillButton(
            context,
            'Message',
            backgroundColor: theme.accentColor,
          ),
        ),
      ],
    );
  }

  Future<bool> sendFriendRequest() async {
    
    setState(() {
      friendStatus = 'Request Sent';
    });
    print("in");
    http.Response res = await http.post(
      'http://192.168.0.110:5000/create_connection',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: 
        jsonEncode(<String,String>{
        "user_id_sender": widget.uid,
        "user_id_receiver": widget.friend_uid,

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
    
    return true;
  }

  Widget _createPillButton(
    var context,
    String text, {
    Color backgroundColor = Colors.transparent,
    Color textColor = Colors.white70,
  }) {
    Function func;
    return new ClipRRect(
      borderRadius: new BorderRadius.circular(30.0),
      child: new MaterialButton(
        minWidth: screenWidth * 0.25,
        color: backgroundColor,
        textColor: textColor,
        onPressed: () {
          switch (text) {
            case "Add Friend":
            //TODO: add friend
              
              break;
            case "Request Sent":
            //TODO: add friend
              
              break;
            case "Message":
            //TODO: add friend
              
              break;
            case "Report":
            //TODO: add friend
              Navigator.push(context, MaterialPageRoute(builder: (context) => Report()));
              break;
            default:
          }
        },
        child: new Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    screenWidth = MediaQuery.of(context).size.width;


    return new Stack(
      children: <Widget>[
        _buildDiagonalImageBackground(context),
        new Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 1.4,
          child: new Column(
            children: <Widget>[
              _buildAvatar(),
              _buildFollowerInfo(textTheme),
              _buildActionButtons(theme, context),
            ],
          ),
        ),
        new Positioned(
          top: 26.0,
          left: 4.0,
          child: new BackButton(color: Colors.white),
        ),
      ],
    );
  }
}
