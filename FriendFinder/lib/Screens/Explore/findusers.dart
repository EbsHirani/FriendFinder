import 'dart:convert';

import 'package:friendfinder/Screens/View_Profile/friend_details_page.dart';
import 'package:friendfinder/Screens/View_Profile/friends/friend.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:friendfinder/models/chat_model.dart';
import 'package:http/http.dart' as http;


class FindNewUsers extends StatefulWidget {
  String uid;
  FindNewUsers({this.uid});
  @override
  _FindNewUsersState createState() => _FindNewUsersState(uid:uid);
}

class _FindNewUsersState extends State<FindNewUsers> {
  String uid;
  _FindNewUsersState({this.uid});
  String genre, stream;
  List li;
  bool load = true;
  Icon filterIcon = new Icon(
    Icons.filter_list,
    color: Colors.black,
  );
  List<String> genreList = [
    "ajld",
    "afljalk",
  ];
  List<String> streamList = [
    "ajfjsa",
    "adkfj",
  ];
  Future<bool> getUsers() async {
    if(load){
    load = false;
    print("in find users");
    print(uid);
    http.Response res = await http.post(
      'http://192.168.0.110:5000/get_match_users',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:jsonEncode(<String,String>{
        "user_id":uid
      })
    );
    // print(jsonDecode(res.body));
    li = jsonDecode(res.body);
    print(li);
    // li = map.keys.toList();
    // print(li.keys);
    }
    return true;
  }
  Widget getSearchBar(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0,18,8,18),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30.0))),
        elevation: 3.0,
        shadowColor: Colors.grey,
        color: Colors.white,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
          padding: EdgeInsets.only(left:10,right:10),
          child: Row(
            children: <Widget>[
              
              IconButton(icon: filterIcon, onPressed:getFilters ),
          ],)
        ),
      ),
    );
  }
  void getFilters() async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(builder:(context, setState){
            return AlertDialog(
            title:Container(
              padding: EdgeInsets.all(20),
              child :Column(
                children: <Widget>[
                  DropdownButtonFormField(
              isExpanded: true,
                items: genreList.map((String category) {
                  return new DropdownMenuItem(
                      value: category,
                      child: Row(                               
                        children: <Widget>[
                          Icon(Icons.arrow_right),
                          Flexible(
                            child: Text(category),
                          ),
                        ],
                        
                      )
                    );
                }).toList(),
                onChanged: (newValue) async {
                  // do other stuff with _category
                  setState(() => genre = newValue);
                // await db.setCurrentstream(newValue);
                },
                value: genre,
                decoration: InputDecoration(
                  enabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  filled: true,
                  // fillColor: Theme.of(context).primaryColor,
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  hintText: 'Choose Gender',
                )),
                Padding(padding:EdgeInsets.all(10)),
                DropdownButtonFormField(
              isExpanded: true,
                items: streamList.map((String category) {
                  return new DropdownMenuItem(
                      value: category,
                      child: Row(                               
                        children: <Widget>[
                          Icon(Icons.arrow_right),
                          Flexible(
                            child: Text(category),
                          ),
                        ],
                        
                      )
                    );
                }).toList(),
                onChanged: (newValue) async {
                  // do other stuff with _category
                  setState(() => stream = newValue);
                // await db.setCurrentCareer(newValue);
                },
                value: stream,
                decoration: InputDecoration(
                  enabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  filled: true,
                  // fillColor: Theme.of(context).primaryColor,
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  hintText: 'Choose Age Category',
                )),
                
                ],
              ),
              ),
              
            actions: <Widget>[
          new FlatButton(
            child: Text("Continue"),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          new FlatButton(
            child: Text("Reset"),
            onPressed: (){
              setState(() {
                genre = null;
                stream = null;
                
              });
              
            },
          ),]
          );
          }
           
          );
          
        },
      );
      // print(genre);
      // print(stream);
      // cancelSearch();
      // applyFilters();
  }
  @override
  Widget build(BuildContext context) {
    // Friend friend = Friend(avatar: "https://miro.medium.com/max/945/1*ilC2Aqp5sZd1wi0CopD1Hw.png",
    //  name: "Varun Magotra",
    //   email: "maimadarchodhu@gmaal.com", 
    //   location: "Dilli se hu benchod", 
    //   friendsCount: 20,
    //   desc: 'Lorem Ipsum is simply dummy text of the printing and typesetting ',
            
    //   );
    return Scaffold(
      appBar: AppBar(
        
          centerTitle:true,
          elevation: 0,
          title: Text("Explore", textScaleFactor: 1.2,),
      ),
      body: 
      Column(
        children: [
          // getSearchBar(),
          Expanded(
            child: FutureBuilder(
              future: getUsers(),
              builder: (context, snapshot) {
                if(snapshot.hasData){

                return ListView.builder(
          itemCount: li.length,
          itemBuilder: (context, i) => new Column(
                children: <Widget>[
                  new Divider(
                    height: 10.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FriendDetailsPage(
                            Friend(
                              
                              avatar: li[i]["user_profile"]["profile_picture"] == null? 
                          "https://miro.medium.com/max/945/1*ilC2Aqp5sZd1wi0CopD1Hw.png":
                          li[i]["user_profile"]["profile_picture"],
                           name: li[i]["user_profile"]["name"],
                            email: li[i]["user_profile"]["email"],
                            likings:li[i]["user_profile"]["interest"],
                             location: "Mumbai",
                              friendsCount: 10,
                               desc: li[i]["user_profile"]["bio"]
                            ),
                            uid : uid,
                            friend_uid: li[i]["user_id"],
                            avatarTag :'imageHero',
                            friendStatus: "Add Friend",
                          ))).then((value) {
                  setState(() {
                    load = true;
                  });
                  });
                    },
                    child: new ListTile(
                      leading: new CachedNetworkImage(
                        imageUrl: li[i]["profile_picture"] == null ?
                        "https://miro.medium.com/max/945/1*ilC2Aqp5sZd1wi0CopD1Hw.png"
                         :li[i]["profile_picture"],
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      title: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(
                            li[i]["name"],
                            style: new TextStyle(fontWeight: FontWeight.bold),
                          ),
                          // new Text(
                          //   dummyData[i].time,
                          //   style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                          // ),
                        ],
                      ),
                      subtitle: new Container(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: new Text(
                          // ignore: todo
                          li[i]["name"], //TODO : Status here
                          style: new TextStyle(color: Colors.grey, fontSize: 15.0),
                        ),
                      ),
                    ),
                  )
                ],
          ),
        );
                }
        else{
          return Center(
                child: CircularProgressIndicator(),
              );
        }
              }
            ),
            )
        ],
      ),
    );
  }
}