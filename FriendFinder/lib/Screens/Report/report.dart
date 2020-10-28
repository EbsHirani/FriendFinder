import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:friendfinder/components/rounded_button.dart';
import 'package:friendfinder/components/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Report extends StatefulWidget {
  
  Report({
    this.uid,
    this.friend_uid,
    this.name,
  });
  String uid, friend_uid, name;
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  String report;
  // String username = "Varun Magotra";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friend Finder"),
        elevation: 0.7, ),
      body: Column(children: [
        new Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: new Text(
            "Why are you reporting "+  widget.name,
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
        Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: RoundedInputField(
                icon: Icons.report,
                hintText: "Report Justification",
                onChanged: (value) {
                  report = value;
                },
              ),
            ),
        Spacer(),
         RoundedButton(
           
        text: "Confirm",
        press: () async{
          if(report != null){
                      http.Response res = await http.post(
              'http://192.168.0.110:5000/report_user',
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: 
                jsonEncode(<String,String>{
                "complainer": widget.uid,
                "complainee": widget.friend_uid,
                'message': report

                })
            
          );
          Navigator.pop(context);

           }
              
            else{
              Fluttertoast.showToast(
                  msg: "Enter all the fields",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
        }
            )
      ],)
    );
  }
}