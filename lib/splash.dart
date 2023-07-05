


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/functions/funcs.dart';
import 'package:flutter_application_1/profilepage.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter/src/painting/gradient.dart' as ln;

class splashscreen extends StatefulWidget{
  const splashscreen({Key? key}): super(key: key);
  @override
  _splashscreen createState() => _splashscreen();
}
//Artboard? _riveArtboard;



class _splashscreen extends State<splashscreen>
with SingleTickerProviderStateMixin{


  late FlutterGifController? controller1;
 @override
  void initState() {
    controller1 = FlutterGifController(vsync: this, duration: const Duration(seconds: 4));
    //FlutterGifController controller1 = FlutterGifController(vsync: this);
    //controller1?.repeat(reverse: false,period: const Duration(seconds: 4),min: 0,max:140 );
    //controller1 = controller1.repeat(min: 0,max: 250,period: const Duration(seconds: 5),reverse: true);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);


    Future.delayed(const Duration(seconds: 8), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder:(_) => const Profilepage(),
        )
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
       overlays: SystemUiOverlay.values);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Container(
        width: double.infinity,
        height: double.infinity,
        decoration:   const BoxDecoration(
          gradient: ln.LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              //Color(0xff1e302f),
              mycolors.buttonNavcolor,
              Colors.orangeAccent,
              Colors.redAccent
             // Colors.red,
              //mycolors.iconcolor,
              
            ],
            stops: [0.3,0.7,0.95]
          )
        ),
        child:
          Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          //   const Text("User Profile"),
            // GifImage(
            //   height: 500,
            //   width: 500,
            //   controller: controller1,
            //   image:  AssetImage('assets/Pirl_gif_png_final.gif') ),
            Container(
              margin: const EdgeInsets.only(top: 100),
            ),
            Animate(
              child: Image.asset('assets/pirlgif1.gif').animate().fade(duration: const Duration(seconds: 2))),
            Animate(
             child :
             Row( 
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const Text("made by AAST",style: TextStyle(fontFamily:'Kalam' ,fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black))
             .animate().fade(delay:const Duration(seconds: 5) ,duration: const Duration(seconds: 2)),
              Container(
                height: 50,
                width: 50,
              child: Image.asset('assets/aast.png').animate().fade(delay:const Duration(seconds: 5) ,duration: const Duration(seconds: 2)),)
             ],
             )
              
          ),
            // GifImage(
            //   controller: controller1!,
            //   image: const AssetImage('assets/pirlgif1.gif'),
            //   width: 200,
            //   height: 400,
              
            // ),

          ],
          )
        ),
    );
    
     
  }
}
