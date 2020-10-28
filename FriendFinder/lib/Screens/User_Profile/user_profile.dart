import 'dart:convert';

import 'package:friendfinder/Screens/Registration/registration.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:friendfinder/Screens/Welcome/welcome_screen.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:friendfinder/constants.dart';
import 'package:friendfinder/widgets/profile_list_item.dart';
import 'package:http/http.dart' as http;

class UserProfile extends StatefulWidget {
  UserProfile({
    this.uid
  });
  String uid;
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool load = true;

  String name, email, url;

  Future<bool> getUser() async {
    if(load){
    load = false;
    print("in");
    http.Response res = await http.post(
      'http://192.168.0.110:5000/get_user_profile',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'user_id': widget.uid}),
    );
    Map map = jsonDecode(res.body);
    name = map["name"];
    email = map["email_id"];
    try{
      url = map["user_profile"]["profile_picture"];
    }
    catch(e){

    }
    print("out");
    
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);

    
    // ignore: non_constant_identifier_names

    var themeSwitcher = ThemeSwitcher(
      builder: (context) {
        return AnimatedCrossFade(
          duration: Duration(milliseconds: 200),
          crossFadeState:
              ThemeProvider.of(context).brightness == Brightness.dark
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
          firstChild: GestureDetector(
            onTap: () =>
                ThemeSwitcher.of(context).changeTheme(theme: kLightTheme),
            child: Icon(
              LineAwesomeIcons.sun,
              size: ScreenUtil().setSp(kSpacingUnit.w * 3),
            ),
          ),
          secondChild: GestureDetector(
            onTap: () =>
                ThemeSwitcher.of(context).changeTheme(theme: kDarkTheme),
            child: Icon(
              LineAwesomeIcons.moon,
              size: ScreenUtil().setSp(kSpacingUnit.w * 3),
            ),
          ),
        );
      },
    );

    
    return ThemeSwitchingArea(
        child: (Builder(
      builder: (context) {
        return Scaffold(
          body: FutureBuilder(
            future: getUser(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
              var profileinfo = Expanded(
      child: Column(
        children: [
          Container(
            height: kSpacingUnit.w * 10,
            width: kSpacingUnit.w * 10,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: kSpacingUnit.w * 5,
                  child : url == null ?Image.asset('assets/images/avatar.png'):Image.network(url),
                ),
                // Align(
                //   alignment: Alignment.bottomRight,
                //   child: Container(
                //     height: kSpacingUnit.w * 2.5,
                //     width: kSpacingUnit.w * 2.5,
                //     decoration: BoxDecoration(
                //       color: Theme.of(context).accentColor,
                //       shape: BoxShape.circle,
                //     ),
                //     child: Icon(
                //       LineAwesomeIcons.pen,
                //       color: kDarkPrimaryColor,
                //       size: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Text(name, style: kTitleTextStyle),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Text(email, style: kCaptionTextStyle),
          SizedBox(height: kSpacingUnit.w * 2),
          // Container(
          //   height: kSpacingUnit.w * 3,
          //   width: kSpacingUnit.w * 20,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
          //     color: Theme.of(context).accentColor,
          //   ),
          //   child: Center(
          //     child: Text(
          //       "Change Password",
          //       style: kButtonTextStyle,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
              
                var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 6),
        
        profileinfo,
        // themeSwitcher,
        SizedBox(width: kSpacingUnit.w * 3),
      ],
    );
                return Column(
                  children: <Widget>[
                    SizedBox(height: kSpacingUnit.w * 5),
                    header,
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          
                          InkWell(
                            onTap:(){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Registration(uid : widget.uid)));
                            },
                            child: ProfileListItem(
                              icon: LineAwesomeIcons.question_circle,
                              text: 'Description/Interests',
                            ),
                          ),
                          
                          InkWell(
                            onTap:(){
                              Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(
                                    builder: (context) => WelcomeScreen()), (route) => false);
                            },
                            child: ProfileListItem(
                              icon: LineAwesomeIcons.alternate_sign_out,
                              text: 'Logout',
                              hasNavigation: false,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }
            else{
              return Center(child: CircularProgressIndicator(),);
            }
            }
          ),
        );
      },
    )));
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;

  const ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSpacingUnit.w * 5.5,
      margin: EdgeInsets.symmetric(
        horizontal: kSpacingUnit.w * 4,
      ).copyWith(
        bottom: kSpacingUnit.w * 2,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: kSpacingUnit.w * 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
        color: Theme.of(context).backgroundColor,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            this.icon,
            size: kSpacingUnit.w * 2.5,
          ),
          SizedBox(width: kSpacingUnit.w * 1.5),
          Text(
            this.text,
            style: kTitleTextStyle.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          if (this.hasNavigation)
            Icon(
              LineAwesomeIcons.angle_right,
              size: kSpacingUnit.w * 2.5,
            ),
        ],
      ),
    );
  }
}
