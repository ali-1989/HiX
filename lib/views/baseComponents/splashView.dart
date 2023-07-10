import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import 'package:app/tools/app/appImages.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SizedBox.expand(
            child: buildBody()
        )
    );
  }

 /* Widget buildBody(){
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.logoSplash),
              fit: BoxFit.fill,
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            FadeIn(
              duration: const Duration(milliseconds: 700),
              child: Image.asset(AppImages.appIcon,
                width: 100,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }*/

  Widget buildBody(){
    return Stack(
      children: [

        SizedBox.expand(
          child:ColoredBox(color: Colors.red,)
        ),
        SvgPicture(
          ExactAssetPicture('assets/splash.svg.vec'),
          fit: BoxFit.fill,
          allowDrawingOutsideViewBox: true,
          alignment: Alignment.center,
        ),
      ],
    );
  }

  Widget buildBody2(){
    return Stack(
      children: [

        SizedBox.expand(
          child:ColoredBox(color: Colors.red,)
        ),
        SvgPicture.asset(
            AppImages.splash,
          fit: BoxFit.fill,
          allowDrawingOutsideViewBox: true,
          alignment: Alignment.center,
        ),
      ],
    );
  }
}
