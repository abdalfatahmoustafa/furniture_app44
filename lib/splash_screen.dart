import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:furniture_app/screens/choose%20user%20type.dart';
import 'package:furniture_app/screens/items%20screen.dart';
import 'package:page_transition/page_transition.dart';
  class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset("images/3alafen.png",height: 500,width: 200,) ,
      nextScreen: ChooseTypeOfUser(),
      splashTransition: SplashTransition.scaleTransition,
      //pageTransitionType: PageTransitionType.scale,
      // color: Color(0xffA64B2A),
      backgroundColor: Color(0xffA64B2A),

    );
  }
}
