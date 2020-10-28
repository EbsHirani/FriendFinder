
import 'package:friendfinder/Screens/ChatScreen/chat_screen.dart';
import 'package:friendfinder/Screens/Explore/explore.dart';
import 'package:friendfinder/Screens/User_Profile/user_profile.dart';
import 'package:friendfinder/Screens/View_Profile/Friend_Page_List.dart';
import 'package:friendfinder/Screens/View_Profile/friend_details_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'Screens/View_Profile/friends/friend.dart';
// import 'admissions/admission.dart';
// import 'exploration_tab/exploration.dart';
// import 'profile.dart';
// import 'dashboard.dart';

class BottomNavigation extends StatefulWidget {
  String uid;
  BottomNavigation({this.uid});
  @override
  _BottomNavigationState createState() => _BottomNavigationState(uid:uid);
}

class _BottomNavigationState extends State<BottomNavigation> with SingleTickerProviderStateMixin{

  String uid;
  _BottomNavigationState({this.uid});
  int _page = 0;
  ChangeNotifier notif = ChangeNotifier();


  var _pageOption;
  @override
  void initState() {
    // Friend friend = Friend(avatar: "https://miro.medium.com/max/945/1*ilC2Aqp5sZd1wi0CopD1Hw.png",
    //  name: "Varun Magotra",
    //   email: "maimadarchodhu@gmaal.com", 
    //   location: "Dilli se hu benchod", 
    //   friendsCount: 20,
    //   desc: 'Lorem Ipsum is simply dummy text of the printing and typesetting ',
            
    //   );
    // TODO: implement initState
    super.initState();
    _pageOption =  [
      ChatScreen(uid : uid, notifier: notif,),
      FriendsListScreen(uid:uid, notifier : notif),
      // FriendDetailsPage(friend,
      //       avatarTag :'imageHero',
      //       friendStatus: "Add Friend",
      //     ),
      Explore(uid:uid, notifier: notif,),
      UserProfile(uid : uid),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        //key: _bottomNavigationKey,
        index: 0,
        height: 45.0,
        items: <Widget>[
          Icon(Icons.home, size: 20, color: Theme.of(context).primaryColor,),
          Icon(Icons.list, size: 20, color: Theme.of(context).primaryColor,),
          Icon(Icons.explore, size: 20, color: Theme.of(context).primaryColor,),
          Icon(Icons.account_circle, size: 20, color: Theme.of(context).primaryColor,),
          //Icon(Icons.perm_identity, size: 30),
        ],
        color: Theme.of(context).accentColor,
        buttonBackgroundColor: Theme.of(context).accentColor,
        backgroundColor: Theme.of(context).primaryColor,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),

      body: IndexedStack(
        index: _page,
        children: _pageOption,
      ),
    );
  }
}