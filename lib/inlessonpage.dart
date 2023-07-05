import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_application_1/inlessonpages/DownloadedFileScreen.dart';
import 'package:flutter_application_1/inlessonpages/materialpage.dart';
import 'package:flutter_application_1/inlessonpages/summariespage.dart';
import 'package:flutter_application_1/inlessonpages/transcriptpage.dart';
import 'package:flutter_application_1/inlessonpages/videospage.dart';
import '../functions/funcs.dart';

class inlessonpage extends StatefulWidget {
  const inlessonpage ({Key? key}): super(key: key);
  @override
  _inlessonpage createState() => _inlessonpage();
}

class _inlessonpage extends State<inlessonpage> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final screens =[
    const DownloadedFilesScreen(),
    const materialpage(),
    const summariespage(),
    const transcriptpage(),
    const videospage()
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mycolors.backgroundColor,
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          height: 60.0,
          items:   const <Widget>[
            Icon(Icons.folder, size: 30,color: mycolors.iconcolor,),
            Icon(Icons.book, size: 30,color: mycolors.iconcolor,),
            Icon(Icons.summarize, size: 30,color: mycolors.iconcolor,),
            Icon(Icons.subtitles, size: 30,color: mycolors.iconcolor,),
            Icon(Icons.video_call_outlined, size: 30,color: mycolors.iconcolor,),
          ],
          color: mycolors.buttonNavcolor,
          buttonBackgroundColor: Colors.transparent,
          backgroundColor: mycolors.backgroundColor,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
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