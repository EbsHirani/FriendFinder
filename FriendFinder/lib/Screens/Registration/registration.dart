import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:friendfinder/components/rounded_button.dart';
import 'package:friendfinder/components/rounded_input_field.dart';
import 'package:friendfinder/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'imageUploader.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String bio;
  File file;
  String uid, url;
  StorageReference ref;
  // File img;
  File _image;
  List<bool> bools = [];
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://friend-finder-69982.appspot.com/');

  StorageUploadTask _uploadTask;

  List all = ["Music", "fadalsjlfs", "asdhfaskj"];

  List selected = [];

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
      body: Container(
        child: Column(
          children: [
            Container(
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
            SizedBox(height: kSpacingUnit.w * 2),
            Text('Adam', style: kTitleTextStyle),
            SizedBox(height: kSpacingUnit.w * 0.5),
            Text('Adam@gmail.com', style: kCaptionTextStyle),
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
              Align(
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
            ]),
            Spacer(),
            RoundedButton(
              text: "Confirm",
              press: () {},
            )
          ],
        ),
      ),
    );
  }
}
