import 'package:friendfinder/Screens/ChatScreen/chat_screen.dart';
import 'package:friendfinder/Screens/Registration/registration.dart';
import 'package:friendfinder/Screens/Signup/signup_screen.dart';
import 'package:friendfinder/Screens/View_Profile/friends/friend.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:friendfinder/Screens/Welcome/welcome_screen.dart';
import 'package:friendfinder/constants.dart';
import 'package:friendfinder/Screens/User_Profile/user_profile.dart';

import 'Screens/Login/login_screen.dart';
import 'Screens/Login/login_screen.dart';
import 'Screens/Registration/registration.dart';
import 'Screens/View_Profile/friend_details_page.dart';
import 'bottom_navigation.dart';
// import 'package:friendfinder/Screens/View_Profile/F';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Friend friend = Friend(
    //   avatar: "https://miro.medium.com/max/945/1*ilC2Aqp5sZd1wi0CopD1Hw.png",
    //   name: "Varun Magotra",
    //   email: "maimadarchodhu@gmaal.com",
    //   location: "Dilli se hu benchod",
    //   friendsCount: 20,
    //   desc: 'Lorem Ipsum is simply dummy text of the printing and typesetting ',
    // );

    return ThemeProvider(
      initTheme: kDarkTheme,
      child: Builder(builder: (context) {
        return FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Auth',
                  // theme: ThemeData(
                  //   primaryColor: kDarkPrimaryColor,
                  //   scaffoldBackgroundColor: Colors.white,
                  // ),
                  theme: ThemeProvider.of(context),
                  // home: BottomNavigation(uid:"QbVVaaiqHJcRpqvVqJjCT69RI302"),
                  // home: Registration(uid: "bMxLnAalZfgfUyLrIyrzsrH91eD3"),
                  home: WelcomeScreen(),
                  // FriendDetailsPage(friend,
                  //   avatarTag :'imageHero',
                  //   friendStatus: "Message",
                  // ),
                );
              } else if (snapshot.hasError) {
                print('error');
              } else {
                return Center(
                    child: SizedBox(
                  height: 36,
                  width: 36,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                  ),
                ));
              }
            });
      }),
    );
  }
}
