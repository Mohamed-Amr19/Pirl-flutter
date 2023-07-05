
import 'package:flutter/material.dart';
import 'package:flutter_application_1/functions/funcs.dart';

class userprofile extends StatefulWidget{
  const userprofile({Key? key}): super(key: key);
  @override
  _userprofile createState() => _userprofile();
}

class _userprofile extends State<userprofile>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mycolors.appbarcolor,
        title: const Text("User Profile"),
      ),
      body: const Center(
        child: Text("User Profile"),
      ),
    );
  }
}

