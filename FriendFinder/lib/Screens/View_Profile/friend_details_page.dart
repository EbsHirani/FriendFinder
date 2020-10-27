import 'package:flutter/material.dart';
import 'package:friendfinder/Screens/View_Profile/footer/articles_showcase.dart';
import 'package:friendfinder/Screens/View_Profile/friend_detail_body.dart';
import 'package:friendfinder/Screens/View_Profile/header/friend_detail_header.dart';
import 'package:friendfinder/Screens/View_Profile/friends/friend.dart';
import 'package:meta/meta.dart';

class FriendDetailsPage extends StatefulWidget {
  FriendDetailsPage(

    this.friend, {
      this.uid,
      this.friend_uid,
      this.friendStatus,
    @required this.avatarTag,
  });
  final String friendStatus;
  final Friend friend;
  final Object avatarTag;
  String uid, friend_uid;
  @override
  _FriendDetailsPageState createState() => new _FriendDetailsPageState();
}

class _FriendDetailsPageState extends State<FriendDetailsPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.friend.likings);
    var linearGradient = const BoxDecoration(
      gradient: const LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: <Color>[
          const Color(0xFF413070),
          const Color(0xFF2B264A),
        ],
      ),
    );

    return new Scaffold(
      body: new Container(
        decoration: linearGradient,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new FriendDetailHeader(

              widget.friend,
              uid: widget.uid,
              friend_uid: widget.friend_uid,
              friendStatus: widget.friendStatus,
              avatarTag: widget.avatarTag,
            ),
            Expanded(
              child: new Padding(
                padding: const EdgeInsets.all(24.0),
                child: new FriendDetailBody(widget.friend),
              ),
            ),
            // new FriendShowcase(widget.friend),
          ],
        ),
      ),
    );
  }
}
