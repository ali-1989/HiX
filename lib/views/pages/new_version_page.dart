import 'dart:math';

import 'package:flutter/material.dart';

import 'package:iris_tools/api/helpers/urlHelper.dart';
import 'package:iris_tools/api/system.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:app/structures/abstract/state_super.dart';
import 'package:app/structures/models/version_model.dart';
import 'package:app/tools/app/app_decoration.dart';
import 'package:app/tools/app/app_images.dart';
import 'package:app/tools/app/app_navigator.dart';
import 'package:app/tools/app/app_themes.dart';

/*
'''
<body>
<span>\u2705</span><p><strong> اضافه شدن درباره ما</strong></p>
<span>\u2705</span><p><strong> تکمیل دروس</strong></p>
<span>\u2705</span><p><strong> تکمیل تراکنش ها</strong></p>
<span>\u2705</span><p><strong> تکمیل کیف پول</strong></p>
</body>
''';
 */

class NewVersionPage extends StatefulWidget {
  final VersionModel versionModel;

  const NewVersionPage({
    Key? key,
    required this.versionModel,
  }) : super(key: key);

  @override
  State<NewVersionPage> createState() => _NewVersionPageState();
}
///================================================================================================
class _NewVersionPageState extends StateSuper<NewVersionPage> {
  String html = '';

  @override
  void initState(){
    super.initState();

    html = widget.versionModel.description?? '--';
  }

  Future<bool> onBack(){
    if(widget.versionModel.restricted){
      System.exitApp();
    }
    else {
      return Future.value(true);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onBack(),
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: hs * .24,
                  child: CustomPaint(
                    painter: MyCustomPainter(),
                    child: const SizedBox(),
                  ),
                )
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: AspectRatio(
                      aspectRatio: 10/7,
                        child: Image.asset(AppImages.newVersion)
                    ),
                  ),

                  SizedBox(height: hs *.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(AppImages.newVersionIco, width: 26,),
                          const SizedBox(width: 10),
                          const Text('تغییرات نسخه جدید', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900))
                        ],
                      ),

                      Text(' ${widget.versionModel.newVersionName}', style: const TextStyle(fontSize: 14))
                    ],
                  ),

                  const SizedBox(height: 30),

                  Expanded(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Scrollbar(
                          thumbVisibility: true,
                          trackVisibility: false,
                          child: SingleChildScrollView(
                            child: HTML.toRichText(context, html, defaultTextStyle: AppThemes.baseTextStyle()),
                          ),
                        ),
                      ),
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: onUpdateClick,
                          child: const Text('بروز رسانی')
                      ),
                    ),
                  ),

                  Visibility(
                    visible: widget.versionModel.directLink != null,
                      child: Center(
                        child: TextButton(
                          onPressed: onDirectLinkClick,
                          child: const Text('لینک مستقیم'),
                        ),
                      )
                  ),

                  Visibility(
                    visible: !widget.versionModel.restricted,
                      child: Center(
                        child: TextButton(
                          onPressed: (){
                            AppNavigator.pop(context);
                          },
                          child: const Text('بعدا'),
                        ),
                      )
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDirectLinkClick(){
    UrlHelper.launchLink(widget.versionModel.directLink!, mode: LaunchMode.externalApplication);

    /*if(widget.versionModel.restricted){
      System.exitApp();
    }
    else {
      AppNavigator.pop(context);
    }*/
  }

  void onUpdateClick(){
    UrlHelper.launchLink(widget.versionModel.storeLink?? '', mode: LaunchMode.externalApplication);
  }
}
///===============================================================================================
class MyCustomPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = AppDecoration.mainColor;

    canvas.drawRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height), paint);

    paint.color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(size.width/2, -2, size.width, size.height+2), paint);

    paint.color = Colors.white;
    canvas.drawArc(Rect.fromLTWH(0.0, -size.height-2, size.width, size.height*2 +2), 0.5 * pi, 0.5 * pi, true, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
   return true;
  }
}
