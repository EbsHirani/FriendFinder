import 'package:flutter/material.dart';
import 'package:friendfinder/Screens/View_Profile/friends/friend.dart';

class FriendDetailBody extends StatelessWidget {
  FriendDetailBody(this.friend);
  final Friend friend;
  

  Widget _likingsTile(String text){
    return new Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: new Text(
        text,
        style:
            TextStyle(color: Colors.white70, fontSize: 16.0 ),
      ),
    );
  }

  Widget _buildLocationInfo(TextTheme textTheme) {
    return new Row(
      children: <Widget>[
        new Icon(
          Icons.place,
          color: Colors.white,
          size: 16.0,
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: new Text(
            friend.location,
            style: textTheme.subhead.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  // Widget _createCircleBadge(IconData iconData, Color color) {
  //   return new Padding(
  //     padding: const EdgeInsets.only(left: 8.0),
  //     child: new CircleAvatar(
  //       backgroundColor: color,
  //       child: new Icon(
  //         iconData,
  //         color: Colors.white,
  //         size: 16.0,
  //       ),
  //       radius: 16.0,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    print(friend.likings);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          friend.name,
          style: textTheme.headline.copyWith(color: Colors.white),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: _buildLocationInfo(textTheme),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: new Text(
            friend.desc,
            style:
                textTheme.body1.copyWith(color: Colors.white70, fontSize: 16.0),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: new Text(
            'Likings and Interest:',
            style:
                textTheme.body1.copyWith(color: Colors.white, fontSize: 10.0),
          ),
        ),
        Expanded(
          child: new ListView.builder(
            itemCount: friend.likings.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _likingsTile(friend.likings[index]);
            },
            
          ),
        ),
      ],
    );
  }
}
