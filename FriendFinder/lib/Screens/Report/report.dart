import 'package:friendfinder/components/rounded_button.dart';
import 'package:friendfinder/components/rounded_input_field.dart';
import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  String report;
  String username = "Varun Magotra";
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
            "Why are you reporting "+  username,
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
              press: (){

              },
            )
      ],)
    );
  }
}