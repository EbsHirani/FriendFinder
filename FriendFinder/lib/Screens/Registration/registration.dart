import 'dart:convert';
import 'dart:io';

import 'package:date_field/date_field.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:friendfinder/components/rounded_button.dart';
import 'package:friendfinder/components/rounded_input_field.dart';
import 'package:friendfinder/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'imageUploader.dart';

class Registration extends StatefulWidget {
  String uid;
  Registration({
    this.uid
  });
  @override
  _RegistrationState createState() => _RegistrationState(uid : uid);
}

class _RegistrationState extends State<Registration> {
  String bio, lang;
  File file;
  String uid, url, name, email;
  StorageReference ref;
  DateTime selectedDate;
  // File img;
  File _image;
  List<bool> bools = [];

  // final FirebaseStorage _storage =
  //     FirebaseStorage(storageBucket: 'gs://friend-finder-69982.appspot.com/');

  // StorageUploadTask _uploadTask;

  List all = ["Music", "fadalsjlfs", "asdhfaskj"];
  List<String> languages = [
    "English",
    "Hindi",
    "Gujarati",
    "Marathi",
  ];

  List selected = [];

  _RegistrationState({
    this.uid
  });

  // void _startUpload() async{

  //   /// Unique file name for the file
  //   String filePath = 'images/${DateTime.now()}.png';
  //    ref = _storage.ref().child(filePath);
  //   setState(() {
  //     _uploadTask = ref.putFile(file);
  //   });

  // }
  // void uploadUrl() async{
  //   url = await ref.getDownloadURL();
  //   print(url);
  //   // Navigator.pop(context, true);
  // }
  // Future<void> _pickImage(ImageSource source) async {
  //   File selected = await ImagePicker.pickImage(source: source);
  //   setState(() {
  //     img = selected;
  //   });
  //   _startUpload();
  //   uploadUrl();
  // Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => Uploader(
  //                   uid: "NrZIV7Lqo1dLrFvQLZnzrPJhn8N2",
  //                   file: selected
  //                 )));
  // }
  Future<bool> getUser() async{
    print("in");
    http.Response res = await http.post(
                  'http://10.0.2.2:5000/get_user_profile',
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    'uid' : uid
                  }),
                );
    Map map = jsonDecode(res.body);
    name = map["name"];
    print("out");
    try{
    url = map["profile_picture"];
    bio = map["bio"];
    email = map["email"];
    selected = map["interest"];
    lang = map["languages"];
    selectedDate = map["dob"];
    }
    catch (e){
      print(e);
    }
    print("done");
    return true;

  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    // for (String i in all) {
    //   if (selected.contains(i)){
    //     bools.add(true);
    //   }
    //   else{
    //     bools.add(false);
    //   }

    // }

    Future uploadPic(BuildContext context) async {
      String fileName = "${DateTime.now()}.png";
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      url = (await firebaseStorageRef.getDownloadURL()).toString();
      setState(() {
        print("Profile Picture uploaded");
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }

    Future getImage() async {
      File image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
      uploadPic(context);
    }

    return Scaffold(
      body: FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {
          if(snapshot.hasData){

          return Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    height: kSpacingUnit.w * 10,
                    width: kSpacingUnit.w * 10,
                    margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
                    child: Container(
                      height: kSpacingUnit.w * 10,
                      width: kSpacingUnit.w * 10,
                      margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 100,
                            // radius: kSpacingUnit.w * 5,
                            child: SizedBox(
                                width: 180,
                                height: 180,
                                child: _image == null
                                    ? Image.asset('assets/images/avatar.png',
                                        fit: BoxFit.fill)
                                    : Image.file(_image, fit: BoxFit.fill)),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () async {
                                getImage();
                              },
                              child: Container(
                                height: kSpacingUnit.w * 2.5,
                                width: kSpacingUnit.w * 2.5,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  LineAwesomeIcons.pen,
                                  color: kDarkPrimaryColor,
                                  size: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: kSpacingUnit.w * 2),
                Text(name, style: kTitleTextStyle),
                SizedBox(height: kSpacingUnit.w * 0.5),
                Text(email, style: kCaptionTextStyle),
                SizedBox(height: kSpacingUnit.w * 2),
                Column(children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: RoundedInputField(
                      hintText: "Your Bio",
                      onChanged: (value) {
                        bio = value;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: DateTimeField(
                selectedDate: selectedDate,
                onDateSelected: (DateTime date) {
                    setState(() {
                      selectedDate = date;
                    });
                },
                lastDate: DateTime(2020),
              ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: DropdownButtonFormField(
              isExpanded: true,
                items: languages.map((String category) {
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
                    setState(() => lang = newValue);
                // await db.setCurrentstream(newValue);
                },
                value: lang,
                decoration: InputDecoration(
                    enabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    filled: true,
                    // fillColor: Theme.of(context).primaryColor,
                    errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                    hintText: 'Choose Prefered Language',
                )),
                  ),
                  Align(
                    child: Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 5,
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemCount: all.length,
                        itemBuilder: (context, index) {
                          return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              margin:
                                  EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                              child: Container(
                                child: CheckboxListTile(
                                    controlAffinity: ListTileControlAffinity.leading,
                                    activeColor: Colors.white,
                                    checkColor: Colors.yellow,
                                    title: Text(
                                      "${all[index]}",
                                      style: TextStyle(
                                          color: selected.contains(all[index])
                                              ? Colors.yellow
                                              : Colors.white),
                                    ),
                                    value: selected.contains(all[index]),
                                    onChanged: (val) {
                                      String checkboxText = all[index];

                                      if (val == true) {
                                        setState(() {
                                          selected.add(checkboxText);
                                          // isLoading = true;
                                        });
                                        // await pr.show();
                                        // DatabaseService(uid: widget.uid).addPassion(checkboxText);
                                        //                                filteredPassions.remove(checkboxText);
                                        //                                filteredPassions.insert(0, checkboxText);
                                        // setState(() {
                                        //   isLoading = false;
                                        // });
                                      } else {
                                        print("remove");

                                        setState(() {
                                          selected.remove(checkboxText);
                                          // isLoading = true;
                                        });
                                        // await pr.show();
                                        //  DatabaseService(uid: widget.uid).deletePassion(checkboxText);
                                        //  setState(() {
                                        //    isLoading = false;
                                        //  });
                                        // }
                                        print(selected);
                                        //  await pr.hide();
                                      }
                                    }),
                              ));
                        },
                      ),
                    ),
                  ),
                ]),
                Spacer(),
                RoundedButton(
                  text: "Confirm",
                  press: () async {
                    if(name == null || lang == null || bio == null || selectedDate ==null || selected.length == 0){
                      Fluttertoast.showToast(
                      msg: "Enter all the fields",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                    }
                    else 
                      {http.Response res = await http.post(
                    'http://10.0.2.2:5000/set_user_profile',
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(<String, dynamic>{
                      "name" : name,
                      "bio" : bio,
                      "interest" : selected,
                      "user_id": uid,
                      "profile_picture" : url,
                      "languages": lang,
                    }),
                  );
                    Map map = jsonDecode(res.body);
                    }
                  },
                )
              ],
            ),
          );
          }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        }
      ),
    );
  }
}
