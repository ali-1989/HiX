import 'package:flutter/material.dart';

import 'package:iris_tools/widgets/custom_card.dart';

import 'package:app/tools/app/app_icons.dart';

class MySheetLayout extends StatefulWidget {
  final Widget body;

  const MySheetLayout({
    Key? key,
    required this.body
  }) : super(key: key);

  @override
  State createState() => _MySheetLayoutState();
}
///===============================================================================================
class _MySheetLayoutState extends State<MySheetLayout> {
  //late AnimationController animCtr;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onCloseClick,
              child: CustomCard(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Transform.translate(
                      offset: const Offset(0, -3),
                      child: const RotatedBox(
                        quarterTurns: 1,
                          child: Icon(AppIcons.arrowLeftIos, size: 14)
                      ),
                    ),
                  ),
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            SizedBox(
              width: double.infinity,
              child: CustomCard(
                color: Colors.white,
                radius: 12,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                  child: widget.body,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onCloseClick() {
   /* animCtr.forward();*/
    Navigator.of(context).pop();
  }
}
