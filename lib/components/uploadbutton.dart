import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';

class UploadButton extends StatefulWidget {
  final TextEditingController attachmentController ;
  UploadButton({Key key,this.attachmentController}) : super(key: key);

  @override
  _UploadButtonState createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {


@override
void initState() { 
  super.initState();
  
}
  _handleUpload()async{
      File file = await FilePicker.getFile();
       String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file":
            await MultipartFile.fromFile(file.path, filename:fileName),
      });
      var response = await Dio().post("https://me-cloud.glitch.me/upload", data: formData);
      Map<String,dynamic> res = Map<String,dynamic>.from(response.data);
            print(res);

      if(res['code']==200){
        setState(() {
          widget.attachmentController.text= "https://me-cloud.glitch.me/download/"+res['data']['file_id'].toString();
        });
      }
  }
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: _handleUpload,
      child: Text("upload file"),
      );
  }
}