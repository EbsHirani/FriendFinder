import 'package:friendfinder/Screens/View_Profile/friends/friend.dart';
import 'package:friendfinder/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:simple_chat_application/Global/Colors.dart' as myColors;
import 'package:friendfinder/Screens/ChatMessage/recieved_message.dart';
import 'package:friendfinder/Screens/ChatMessage/sent_message.dart';

class ChatPageView extends StatefulWidget {
  // final String username;
  final String uid, friendId, name, friendStatus, avatarTag;
  final Friend friend;
  const ChatPageView({
    this.avatarTag,
    this.friendStatus,
    this.friend,
    this.uid,
    this.friendId,
    this.name,
  });

  @override
  _ChatPageViewState createState() => _ChatPageViewState();
}

class _ChatPageViewState extends State<ChatPageView> {
  TextEditingController _text = new TextEditingController();
  ScrollController _scrollController = ScrollController();
  var childList = <Widget>[];
  // String uid, friendId;
  var recentJobsRef;

  @override
  void initState() {
    super.initState();
    recentJobsRef  = FirebaseFirestore.instance.collection('messages').doc(widget.uid).collection(widget.friendId).orderBy("timestamp", descending: true);
    
  }
  sendMsg() async{
    String msg = _text.text.trim();

    /// Upload images to firebase and returns a URL
    if (msg.isNotEmpty) {
      print('thisiscalled $msg');
      var ref = FirebaseFirestore.instance
          .collection('messages')
          .doc(widget.uid)
          .collection(widget.friendId)
          .doc(DateTime.now().toString());
      await ref.set(
        {
          "sender": widget.uid,
          
          "timestamp": DateTime.now().toString(),
          'content': msg,
          "type": 'text',
        });
      ref = FirebaseFirestore.instance
          .collection('messages')
          .doc(widget.friendId)
          .collection(widget.uid)
          .doc(DateTime.now().toString());
      await ref.set(
        {
          "sender": widget.uid,
          
          "timestamp": DateTime.now().toString(),
          'content': msg,
          "type": 'text',
        });
      
      
      // FirebaseFirestore.instance.runTransaction((transaction) async {
      //   await transaction.set(ref, {
      //     "senderId": uid,
          
      //     "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      //     'content': msg,
      //     "type": 'text',
      //   });
      // });

      _scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 100), curve: Curves.bounceInOut);
    } else {
      print('Please enter some text to send');
    }
  }
  @override
  void dispose() {
    super.dispose();
  }
  Widget buildItem(Message message){
    if(message.sender == widget.uid){
      return SendedMessageWidget(
        content: message.message,
        time : message.timeStamp.toString()
      );
    }
    else{
      return ReceivedMessageWidget(
        content: message.message,
        time : message.timeStamp.toString()
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: 65,
                    child: Container(
                      color: Colors.blue.withOpacity(1),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                widget.name,
                                style: TextStyle(color: Colors.white, fontSize: 15),
                              ),
                              // Text(
                              //   "online",
                              //   style: TextStyle(color: Colors.white60, fontSize: 12),
                              // ),
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                            child: Container(
                              child: ClipRRect(
                                child: Container(
                                    child: SizedBox(
                                      child: Image.asset(
                                        "assets/images/person1.jpg",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    color: Colors.orange),
                                borderRadius: new BorderRadius.circular(50),
                              ),
                              height: 55,
                              width: 55,
                              padding: const EdgeInsets.all(0.0),
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5.0,
                                        spreadRadius: -1,
                                        offset: Offset(0.0, 5.0))
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 0,
                    color: Colors.black54,
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    // height: 500,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      // decoration: BoxDecoration(
                      //   image: DecorationImage(
                      //       image: AssetImage(
                      //           "assets/images/chat-background-1.jpg"),
                      //       fit: BoxFit.cover,
                      //       colorFilter: ColorFilter.linearToSrgbGamma()),
                      // ),
                      child: StreamBuilder(
                        stream: recentJobsRef.snapshots(),
                        builder: (context, snapshot) {  
                          if(snapshot.hasData ){
                              return ListView.builder(controller: _scrollController,
                                itemBuilder: (listContext, index){
                                    var doc = snapshot.data.documents[index];
                                    print("date");
                                    print(doc["timestamp"]);
                                    
                                    DateTime dateTime = DateTime.parse(doc["timestamp"]);
                                    return buildItem(Message(
                                      message : doc["content"],
                                      sender : doc["sender"],
                                      timeStamp: dateTime,

                                    ));
                                },
                                itemCount: snapshot.data.documents.length,
                                reverse: true,)
                                              ;
                          }
                          else{
                              return Center(
                                child: SizedBox(
                              height: 36,
                              width: 36,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                              ),
                            ));
                          }
                          
                        }
                      ),
                    ),
                  ),
                  Divider(height: 0, color: Colors.black26),
                  // SizedBox(
                  //   height: 50,
                  Container(
                    // color: Colors.white,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        maxLines: 20,
                        controller: _text,
                        decoration: InputDecoration(
                          // contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              sendMsg();
                            },
                          ),
                          border: InputBorder.none,
                          hintText: "enter your message",
                        ),
                      ),
                    ),
                  ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}