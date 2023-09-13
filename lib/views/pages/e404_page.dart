import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import 'package:app/tools/app/app_images.dart';
import 'package:app/tools/app/app_messages.dart';
import 'package:app/tools/app/app_themes.dart';

class E404Page extends StatefulWidget{

  const E404Page({Key? key}) : super(key: key);

  @override
  State<E404Page> createState() => _E404PageState();
}
///============================================================================================
class _E404PageState extends State<E404Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50,),

                Text(AppMessages.e404, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ],
            ),
          )
      ),
    );
  }
}
