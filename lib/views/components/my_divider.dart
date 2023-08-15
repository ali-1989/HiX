import 'package:flutter/material.dart';

import 'package:app/tools/app/appDecoration.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: SizedBox(
              height: 1.2,
              child: ColoredBox(
                color: AppDecoration.mainColor,
              ),
            )
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: DecoratedBox(
            decoration: ShapeDecoration(
              shape: CircleBorder(side: BorderSide(color: AppDecoration.mainColor, width: 1.2)),
            ),
            child: const SizedBox(
              height: 14,
              width: 14,
            ),
          ),
        ),

        Expanded(
            child: SizedBox(
              height: 1.2,
              child: ColoredBox(
                color: AppDecoration.mainColor,
              ),
            )
        ),
      ],
    );
  }
}
