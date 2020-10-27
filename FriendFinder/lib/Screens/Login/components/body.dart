import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:friendfinder/Screens/Login/components/background.dart';
import 'package:friendfinder/Screens/Signup/signup_screen.dart';
import 'package:friendfinder/bottom_navigation.dart';
import 'package:friendfinder/components/already_have_an_account_acheck.dart';
import 'package:friendfinder/components/rounded_button.dart';
import 'package:friendfinder/components/rounded_input_field.dart';
import 'package:friendfinder/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;


class Body extends StatefulWidget {

  Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email, pass;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                pass = value;
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () async {
                http.Response response = await  http.post(
                  'http://192.168.0.110:5000/login',
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    'email': email,
                    'password': pass,
                  }),
                );
                Map<String, dynamic> map = jsonDecode(response.body);
                String uid = map["user_id"];
                Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(
                    builder: (context) {
                      return BottomNavigation(uid:uid);
                    },
                  ), (route) => false);
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
