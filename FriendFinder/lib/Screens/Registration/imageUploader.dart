import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Uploader extends StatefulWidget {
  final File file;
  final String uid;
  Uploader({this.file, this.uid});
  @override
  _UploaderState createState() => _UploaderState(uid: uid, file: file);
}

class _UploaderState extends State<Uploader> {
  File file;
  String uid, url;
  StorageReference ref;

  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://friend-finder-69982.appspot.com/');

  StorageUploadTask _uploadTask;

  _UploaderState({this.uid, this.file});
  /// Starts an upload task
  void _startUpload() async{

    /// Unique file name for the file
    String filePath = 'images/${DateTime.now()}.png';
     ref = _storage.ref().child(filePath);
    setState(() {
      _uploadTask = ref.putFile(file);
    });
    

  }
  void uploadUrl() async{
    url = await ref.getDownloadURL();
    print(url);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    _startUpload();
    if (_uploadTask != null) {

      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;
            if (progressPercent == 1){
              Navigator.pop(context);
            }
            if (_uploadTask.isComplete)
              uploadUrl();
              

            return Column(

                children: [
                  
                    
                    


                  if (_uploadTask.isPaused)
                    FlatButton(
                      child: Icon(Icons.play_arrow),
                      onPressed: _uploadTask.resume,
                    ),

                  if (_uploadTask.isInProgress)
                    FlatButton(
                      child: Icon(Icons.pause),
                      onPressed: _uploadTask.pause,
                    ),

                  // Progress bar
                  LinearProgressIndicator(value: progressPercent),
                  Text(
                    '${(progressPercent * 100).toStringAsFixed(2)} % '
                  ),
                ],
              );
          });

          
    } else {

      // Allows user to decide when to start the upload
      return FlatButton.icon(
          label: Text('Upload to Firebase'),
          icon: Icon(Icons.cloud_upload),
          onPressed: _startUpload,
        );

    }
  }}