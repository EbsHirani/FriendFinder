import 'package:flutter/material.dart';
import 'package:FriendFinder/Screens/View_Profile/header/diagonally_cut_colored_image.dart';
import 'package:FriendFinder/Screens/View_Profile/friends/friend.dart';
import 'package:meta/meta.dart';

class FriendDetailHeader extends StatelessWidget {
  static const BACKGROUND_IMAGE = 'assets/images/login_bottom.png';

  FriendDetailHeader(
    this.friend, {
      this.friendStatus,
    @required this.avatarTag,
  });
  final String friendStatus;
  final Friend friend;
  final Object avatarTag;

  Widget _buildDiagonalImageBackground(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return new DiagonallyCutColoredImage(
      new Image.asset(
        BACKGROUND_IMAGE,
        width: screenWidth,
        height: 280.0,
        fit: BoxFit.cover,
      ),
      color: const Color(0xBB8338f4),
    );
  }

  Widget _buildAvatar() {
    return new Hero(
      tag: avatarTag,
      child: new CircleAvatar(
        backgroundImage: new NetworkImage(friend.avatar),
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

  Widget _buildActionButtons(ThemeData theme,) {
    return new Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 16.0,
        right: 16.0,
      ),
      child: friendStatus == "Add Friend" ? _createPillButton(
        'Add Friend',
        backgroundColor: theme.accentColor,
      )
      :
      friendStatus == "Request Sent"?
      _createPillButton(
        'Request Sent',
        backgroundColor: Colors.black,
      ):
      _createPillButton(
        'Message',
        backgroundColor: theme.accentColor,
      ),
    );
  }

  Widget _createPillButton(
    String text, {
    Color backgroundColor = Colors.transparent,
    Color textColor = Colors.white70,
  }) {
    return new ClipRRect(
      borderRadius: new BorderRadius.circular(30.0),
      child: new MaterialButton(
        minWidth: 140.0,
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
              _buildActionButtons(theme),
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
