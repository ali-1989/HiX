import 'dart:async';

import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iris_pic_editor/pic_editor.dart';
import 'package:iris_tools/api/helpers/colorHelper.dart';
import 'package:iris_tools/api/helpers/fileHelper.dart';
import 'package:iris_tools/features/overlayDialog.dart';
import 'package:iris_tools/modules/stateManagers/assist.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:app/structures/abstract/state_super.dart';
import 'package:app/structures/enums/enums.dart';
import 'package:app/structures/models/user_model.dart';
import 'package:app/tools/app/app_decoration.dart';
import 'package:app/tools/app/app_directories.dart';
import 'package:app/tools/app/app_sheet.dart';
import 'package:app/tools/permission_tools.dart';

class ProfilePage extends StatefulWidget {
  //final UserModel userModel;

  ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
///===================================================================================================================
class _ProfilePageState extends StateSuper<ProfilePage> {
  TextEditingController nameTextCtr = TextEditingController();
  TextEditingController familyTextCtr = TextEditingController();
  TextEditingController emailTextCtr = TextEditingController();
  TextEditingController mobileTextCtr = TextEditingController();
  TextEditingController ibanTextCtr = TextEditingController();


  @override
  void initState(){
    super.initState();

  }

  @override
  void dispose(){
    nameTextCtr.dispose();
    familyTextCtr.dispose();
    emailTextCtr.dispose();
    mobileTextCtr.dispose();
    ibanTextCtr.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Assist(
      controller: assistCtr,
      builder: (_, ctr, data) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox(),
        );
      }
    );
  }

  void onSelectAvatar(int state) async {
    AppSheet.closeSheet(context);

    XFile? image;

    if(state == 1){
      image = await selectImageFromCamera();
    }
    else {
      image = await selectImageFromGallery();
    }

    if(image == null){
      return;
    }

    String? path = await editImage(image.path);

    if(path != null){
      //uploadAvatar(path);
    }
  }

  Future<XFile?> selectImageFromCamera() async {
    final hasPermission = await PermissionTools.requestStoragePermission();

    if(hasPermission != PermissionStatus.granted) {
      return null;
    }

    final pick = await ImagePicker().pickImage(source: ImageSource.camera);

    if(pick == null) {
      return null;
    }

    return pick;
  }

  Future<XFile?> selectImageFromGallery() async {
    final hasPermission = await PermissionTools.requestStoragePermission();

    if(hasPermission != PermissionStatus.granted) {
      return null;
    }

    final pick = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(pick == null) {
      return null;
    }

    return pick;
  }

  Future<String?> editImage(String imgPath) async {
    final comp = Completer<String?>();

    final editOptions = EditOptions.byFile(imgPath);
    editOptions.cropBoxInitSize = const Size(200, 170);
    editOptions.primaryColor = ColorHelper.buildMaterialColor(Colors.black87);
    editOptions.secondaryColor = AppDecoration.gray;
    editOptions.iconsColor = Colors.white;


    void onOk(EditOptions op) async {
      final pat = AppDirectories.getSavePathByPath(SavePathType.userProfile, imgPath)!;

      FileHelper.createNewFileSync(pat);
      FileHelper.writeBytesSync(pat, editOptions.imageBytes!);

      comp.complete(pat);
    }

    editOptions.callOnResult = onOk;
    final ov = OverlayScreenView(content: PicEditor(editOptions));
    OverlayDialog().show(context, ov).then((value){
      if(!comp.isCompleted){
        comp.complete(null/*imgPath*/);
      }
    });

    return comp.future;
  }

  void onIbanQuestionMarkClick(){
    OverlayDialog.showMiniInfo(
        context,
        child: const Text('شماره شبا برای برگرداندن اعتبار کیف پول به شما (در صورت نیاز) استفاده می شود'),
        builder :(_, c){
          return Bounce(child: c);
        }
    );
  }


}
