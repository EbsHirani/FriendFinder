import 'package:FriendFinder/Screens/ChatScreen/chat_screen.dart';
import 'package:FriendFinder/Screens/Registration/registration.dart';
import 'package:FriendFinder/Screens/View_Profile/friends/friend.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:FriendFinder/Screens/Welcome/welcome_screen.dart';
import 'package:FriendFinder/constants.dart';
import 'package:FriendFinder/Screens/User_Profile/user_profile.dart';

import 'Screens/View_Profile/friend_details_page.dart';
import 'bottom_navigation.dart';
// import 'package:FriendFinder/Screens/View_Profile/F';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return ThemeProvider(
      initTheme: kDarkTheme,
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Auth',
          // theme: ThemeData(
          //   primaryColor: kDarkPrimaryColor,
          //   scaffoldBackgroundColor: Colors.white,
          // ),
          theme: ThemeProvider.of(context),
          home: BottomNavigation()
        );
      }),
    );
  }
}
