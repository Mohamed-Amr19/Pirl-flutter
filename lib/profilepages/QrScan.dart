import 'package:flutter/material.dart';
// import 'package:pirl_login/controllers/class_controller.dart';
// import 'package:pirl_login/controllers/login_controller.dart';
// import 'package:pirl_login/utils/api_endpoints.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/functions/funcs.dart';
import 'package:flutter_application_1/inlessonpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class QrScan extends StatefulWidget{
  const QrScan({Key? key}): super(key: key);
  @override
  _QrScanState createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  TextEditingController userController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  String? cameraScanResult = "none";
  String token = "temporary token";
  late UserData userData;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mycolors.appbarcolor,
        title: const Text('Sign up API'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: userController,
            decoration: const InputDecoration(
                hintText: 'Username'
            ),
          ),
          const SizedBox(height: 20,),
          TextFormField(
            controller: userIdController,
            decoration: const InputDecoration(
                hintText: 'User ID'
            ),
          ),
          // const SizedBox(height: 40,),
          // GestureDetector(
          //     onTap: () async {
                
          //       //Navigator.popAndPushNamed(context, "/settings");
          //     },
          //   child: Container(
          //     height: 50,
          //     decoration: BoxDecoration(
          //       color: Colors.green,
          //       borderRadius: BorderRadius.circular(10)
          //     ),
          //     child: const Center(child: Text('Save User'),),
          //   )
          // ),
          GestureDetector(
              onTap: () async {
                initUser(userController.text.toString(), 
                userIdController.text.toString());
                await ApiEndPoints.scanApiEndPoint();
                await attend(token);
                //Navigator.popAndPushNamed(context, "/inlessonpage");
                if(!mounted) return;
                Navigator.push(context, MaterialPageRoute(builder: (context) => const inlessonpage()));

              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: const Center(child: Text('attend'),),
              )
          ),
        ],
      ),
    );
  }
}