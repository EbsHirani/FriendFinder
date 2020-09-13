import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
// import 'package:FriendFinder/Screens/Welcome/welcome_screen.dart';
import 'package:FriendFinder/constants.dart';
import 'package:FriendFinder/Screens/User_Profile/user_profile.dart';

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
          home: UserProfile(),
        );
      }),
    );
  }
}
