import 'package:FriendFinder/components/rounded_input_field.dart';
import 'package:FriendFinder/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';


class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String bio;
  List all = [
    "hakjfak",
    "fadalsjlfs",
    "asdhfaskj"
  ];
  List selected = [];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);

    return Scaffold(
      body: Container(
        child: Column(children: [
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
                  radius: kSpacingUnit.w * 5,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: (){
                      print("bitch");
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
          
          Expanded(
            child: ListView(
              children: [
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
                            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 5,
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                            itemCount: all.length,
                            itemBuilder: (context,index){
                              return Container(
                                decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  
                                ),
                                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                                child: Container(
                                  child: CheckboxListTile(
                                  controlAffinity: ListTileControlAffinity.leading,
                                  activeColor: Colors.white,
                                  checkColor: Colors.yellow,
                                  title: Text("${all[index]}",style: TextStyle(color: selected.contains(all[index])? Colors.yellow : Colors.white),),
                                  value: selected.contains(all[index]),
                                  onChanged: (val){
                                    String checkboxText=all[index];
                                    
                                      if(val==true){
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
                                      }

                                      else{
                                        print("remove");
                                          selected.remove(checkboxText);
                                        setState(() {
                                          
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
                                  }
                                                            ),
                                )
                                
                                
                              );
                            },
                          ),
              )
              ]
            ),
          ),
        ],),
      ),
    );
  }
}