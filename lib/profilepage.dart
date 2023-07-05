import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_application_1/functions/funcs.dart';
import 'package:flutter_application_1/profilepages/QrScan.dart';
import 'package:flutter_application_1/profilepages/userprofile.dart';

class Profilepage extends StatefulWidget {
  const Profilepage ({Key? key}): super(key: key);
  @override
  _profilepagestate createState() => _profilepagestate();
}

class _profilepagestate extends State<Profilepage>{

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final screens =[
    
    const QrScan(),
    const userprofile(),
    
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          
          height: 60.0,
          items: const <Widget>[
            Icon(Icons.qr_code_scanner, size: 30,color: mycolors.iconcolor,),
            Icon(Icons.person, size: 30, color: mycolors.iconcolor,),
          ],
          color: mycolors.buttonNavcolor,
          buttonBackgroundColor: mycolors.backgroundColor,
          backgroundColor: mycolors.backgroundColor,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (selectedIndex) {
            setState(() {
              index = selectedIndex;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: screens[index]);
  }



}