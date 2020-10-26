import 'package:friendfinder/Screens/Explore/findusers.dart';
import 'package:friendfinder/Screens/Explore/requests.dart';
import "package:filter_list/filter_list.dart";
import 'package:flutter/material.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Explore",
            textScaleFactor: 1.2,
          ),
        ),
        body: Column(children: [
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RequestsPage()));
              },
              child: new Card(
                  color: Colors.grey[20],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                        color: Theme.of(context).accentColor, width: 1),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                            child: Text(
                              "View Requests",
                              style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )),
                        new Spacer(),
                        Icon(
                          Icons.account_circle,
                          color: Theme.of(context).accentColor,
                        )
                      ],
                    ),
                  ))),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FindNewUsers()));
              },
              child: new Card(
                  color: Colors.grey[20],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                        color: Theme.of(context).accentColor, width: 1),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                            child: Text(
                              "Find new users",
                              style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )),
                        new Spacer(),
                        Icon(Icons.person, color: Theme.of(context).accentColor)
                      ],
                    ),
                  )))
        ]));
  }
}
