// import 'package:flutter/material.dart';


// void _loadFileList() async {
//     // final response =
//     //     await http.get(Uri.parse('http://192.168.1.6:8000/list-directory/'));
//     final response =
//         await http.get(Uri.http("192.168.1.6:8000","list-directory/material"));
//     print("a7aaaaaaaaaaa");
//     print(response.body); // Replace with your server URL
//     final jsonData = json.decode(response.body);
//     print(jsonData);
//     setState(() {
//       _fileList = List<String>.from(jsonData);
//     });
//   }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _GetEndPoints {
  final String listDirectory = 'list-directory';
  final String attend = 'attend/';
  final String registerUser = 'download';
  final String check = "OK";
}

class mycolors{
  static const Color appbarcolor = Colors.transparent;
  static const Color backgroundColor = Color(0xfff7f5fa);
  static const Color textColor = Colors.black;
  static const Color buttonNavcolor = Color.fromRGBO(45, 68, 67,1);
  static const Color iconcolor = Colors.orange;
}
class ApiEndPoints{
  // static late String baseUrl; //10.0.2.2:8000
  static String baseUrl = "10.0.2.2:8000"; //10.0.2.2:8000
  static late String token;
  static late String lessonId;
  static late String className;
  static late int classId;
  static _GetEndPoints authEndpoints = _GetEndPoints();
  static Future<void> scanApiEndPoint() async 
  {
    late String? cameraScanResult;
    late dynamic jsonObject;
    if (await Permission.camera.request().isGranted) {
      cameraScanResult = await scanner.scan();
      jsonObject = json.decode(cameraScanResult.toString());
      print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
      print(cameraScanResult);
      baseUrl = jsonObject["address"];//cameraScanResult.toString();
      token = jsonObject["token"];
      lessonId = jsonObject["lessonId"];
      className = jsonObject["className"];
      classId = jsonObject["classId"];
    }
  }
}

class UserData {
  late bool initStatus;
  late String user;
  late String userId;
  UserData();
  UserData.prefsInit(SharedPreferences prefs){
    initStatus = prefs.getBool("initialized") ?? false;
    user = prefs.getString("user").toString();
    userId = prefs.getString("userId").toString();
  }
  UserData.init(this.initStatus, this.user,this.userId);
}

void initUser(String username, userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("initialized", true);
  prefs.setString("user", username);
  prefs.setString("userId", userId);
}

Future<void> attend(token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  UserData userData = UserData.prefsInit(prefs);
  var url = Uri.http(ApiEndPoints.baseUrl, ApiEndPoints.authEndpoints.attend);
  try{
    Response response = await post(
      // Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.attend),
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
          'user': userData.user,
          'userId': userData.userId,
          'lessonId': ApiEndPoints.lessonId,
          'token': token,
          'classId':ApiEndPoints.classId,
        })
    );
    if (response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      print(data);
      print("account created successfully");
    } else {
      print("attendance failed");
      print(jsonDecode(response.body.toString()));
    }
  } catch(e){
    print(e.toString());
  }
}

