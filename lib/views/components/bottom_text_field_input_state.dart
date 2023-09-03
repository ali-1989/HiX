import 'package:app/tools/app/appDecoration.dart';
import 'package:app/tools/app/appIcons.dart';
import 'package:flutter/material.dart';
import 'package:iris_tools/widgets/customCard.dart';

typedef OnConfirm = void Function(BuildContext context, String text);

class BottomTextFieldInput extends StatefulWidget {
  final String title;
  final OnConfirm onConfirm;

  const BottomTextFieldInput({
  super.key,
  required this.title,
  required this.onConfirm,
  });

  @override
  State<StatefulWidget> createState() {
    return BottomTextFieldInputState();
  }
}
///========================================================================
class BottomTextFieldInputState extends State<BottomTextFieldInput> {
  TextEditingController txtCtr = TextEditingController();


  @override
  void dispose(){
    txtCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 3),
                  ]
              ),
              child: CustomCard(
                color: Colors.white,
                radius: 0,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title),

                    const SizedBox(height: 5),
                    TextField(
                      controller: txtCtr,
                      decoration: AppDecoration.outlineBordersInputDecoration.copyWith(
                          isDense: true,
                          suffixIcon: GestureDetector(
                            onTap: (){
                              widget.onConfirm(context, txtCtr.text);
                            },
                            child: const Icon(AppIcons.downloadDone),
                          ),
                          suffixIconColor: Colors.green
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}