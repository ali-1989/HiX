import 'package:flutter/material.dart';

import 'package:app/tools/app/appImages.dart';
import 'package:app/tools/app/appSizes.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SizedBox.expand(
            child: buildBody(context)
        )
    );
  }

 Widget buildBody(BuildContext context){
    return Stack(
      fit: StackFit.expand,
      children: [

        const DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE2DBFF), Color(0xFF3C0DF9)],
                  begin: FractionalOffset.topLeft,
                  end: Alignment(0.9, 0.9)
                )
            ),
        ),

        CustomPaint(
          painter: MakeCircle(),
        ),

        Positioned(
          top: AppSizes.getScreenHeight(context)/4,
            left: 0,
            right: 0,
            bottom: 0,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.backgroundPlus),
                    fit: BoxFit.fill,
                  )
              ),
            ),
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[

            Image.asset(AppImages.splashWelcome,
              width: 85,
              height: 85,
            )
          ],
        ),
      ],
    );
  }
}
///=====================================================================
class MakeCircle extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.white12;
    var position = Offset(size.width /2, 100);
    canvas.drawCircle(position, size.width, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
