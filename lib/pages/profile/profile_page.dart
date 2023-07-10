import 'dart:async';
import 'dart:io';

import 'package:app/views/baseComponents/appBarBuilder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iris_notifier/iris_notifier.dart';
import 'package:iris_pic_editor/picEditor/models/edit_options.dart';
import 'package:iris_pic_editor/picEditor/picEditor.dart';
import 'package:iris_tools/api/generator.dart';
import 'package:iris_tools/api/helpers/fileHelper.dart';
import 'package:iris_tools/api/helpers/focusHelper.dart';
import 'package:iris_tools/api/helpers/jsonHelper.dart';
import 'package:iris_tools/api/helpers/mathHelper.dart';
import 'package:iris_tools/api/helpers/pathHelper.dart';
import 'package:iris_tools/dateSection/dateHelper.dart';
import 'package:iris_tools/features/overlayDialog.dart';
import 'package:iris_tools/models/dataModels/mediaModel.dart';
import 'package:iris_tools/modules/stateManagers/assist.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:app/services/session_service.dart';
import 'package:app/structures/abstract/stateBase.dart';
import 'package:app/structures/enums/appEvents.dart';
import 'package:app/structures/enums/enums.dart';
import 'package:app/structures/middleWares/requester.dart';
import 'package:app/structures/models/userModel.dart';
import 'package:app/system/extensions.dart';
import 'package:app/system/keys.dart';
import 'package:app/tools/app/appDirectories.dart';
import 'package:app/tools/app/appIcons.dart';
import 'package:app/tools/app/appImages.dart';
import 'package:app/tools/app/appMessages.dart';
import 'package:app/tools/app/appOverlay.dart';
import 'package:app/tools/app/appSheet.dart';
import 'package:app/tools/app/appSizes.dart';
import 'package:app/tools/app/appSnack.dart';
import 'package:app/tools/app/appThemes.dart';
import 'package:app/tools/app/appToast.dart';
import 'package:app/tools/deviceInfoTools.dart';
import 'package:app/tools/permissionTools.dart';
import 'package:app/tools/routeTools.dart';
import 'package:app/views/components/changeNameFamilyView.dart';
import 'package:app/views/components/dateComponents/selectDateCalendarView.dart';
import 'package:app/views/components/selectGenderView.dart';

class ProfilePage extends StatefulWidget{

  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
///==================================================================================
class _ProfilePageState extends StateBase<ProfilePage> {
  Requester requester = Requester();
  UserModel user = SessionService.getLastLoginUser()!;

  @override
  void initState(){
    super.initState();

    requestProfileData();
    //addPostOrCall(fn: checkPermission);
  }

  @override
  void dispose(){
    requester.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Assist(
        controller: assistCtr,
        builder: (context, ctr, data) {
          return Scaffold(
            //extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: AppBarCustom(
              title: Text(AppMessages.profileTitle),
            ),
            body: buildBody(),
          );
        }
    );
  }

  Widget buildBody(){
    return Stack(
      children: [

        Positioned(
          top: MathHelper.percent(AppSizes.instance.appHeight, 25),
            left: MathHelper.percent(AppSizes.instance.appWidthRelateWeb, 10),
            right: MathHelper.percent(AppSizes.instance.appWidthRelateWeb, 16),
            child: Column(
              children: [

                SizedBox(height: 80,),

              ],
            )
        ),
      ],
    );
  }

  void changeBirthdateClick() async {
    await AppSheet.showSheetCustom(
        context,
        builder: (_){
          return SelectDateCalendarView(
            minYearAsGregorian: 1922,
            maxYearAsGregorian: 2020,
            title: 'تاریخ تولد',
            currentDate: user.birthDate,
            onSelect: (dt){
              RouteTools.popTopView(context: context);
              uploadBirthdate(dt);
            },
          );
        },
        routeName: 'changeBirthdate'
    );
  }

  void changeGenderClick() async {
    await AppSheet.showSheetCustom(
        context,
        builder: (_){
          return SelectGenderView(
            title: 'جنسیت',
            genderType: user.sex == 1? GenderType.man: (user.sex == 2 ? GenderType.woman: GenderType.other),
            onSelect: (gender){
              RouteTools.popTopView(context: context);
              uploadGender(gender == GenderType.man? 1: 2);
            },
          );
        },
        routeName: 'changeGender',
    );
  }

  void changeNameFamilyClick() async {
    final inject = ChangeNameFamilyViewInjection();
    inject.nameHint = 'نام';
    inject.familyHint = 'فامیلی';
    inject.name = user.name;
    inject.family = user.family;
    inject.pageTitle = 'تغییر نام';

    inject.onButton = (name, family){
      if(name.isEmpty){
        AppSnack.showInfo(context, AppMessages.enterName);
        return;
      }

      if(family.isEmpty){
        AppSnack.showInfo(context, AppMessages.enterFamily);
        return;
      }

      FocusHelper.hideKeyboardByUnFocusRoot();
      uploadName(name, family);
    };

    final body = ChangeNameFamilyView(
      injection: inject,
    );

    final view = OverlayScreenView(content: body);

    AppOverlay.showDialogScreen(context, view, canBack: true);
  }

  void changeAvatarClick() async {
    List<Widget> widgets = [];

    if(!kIsWeb) {
      final v = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          onSelectProfile(1);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Icon(AppIcons.camera, size: 20),
              SizedBox(width: 12),
              Text('دوربین').bold(),
            ],
          ),
        ),
      );

      //widgets.add(v); todo:temp-action
    }

    widgets.add(
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            onSelectProfile(2);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Icon(AppIcons.picture, size:20),
                SizedBox(width: 12),
                Text('گالری').bold(),
              ],
            ),
          ),
        ));

    if(user.profileModel != null){
      widgets.add(
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: deleteProfile,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Icon(AppIcons.delete, size: 20),
                  SizedBox(width: 12),
                  Text('حذف').bold(),
                ],
              ),
            ),
          ));
    }

   AppSheet.showSheetMenu(
        context,
        widgets,
        'changeAvatar',
    );
  }

  void onSelectProfile(int state) async {
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
      uploadAvatar(path);
    }
  }

  Future<XFile?> selectImageFromCamera() async {
    final hasPermission = await PermissionTools.requestCameraPermission();

    if(hasPermission != PermissionStatus.granted) {
      AppToast.showToast(context, 'لطفا مجوز استفاده از دوربین را فعال کنید');
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

    void onOk(EditOptions op) async {
      final pat = AppDirectories.getSavePathByPath(SavePathType.userProfile, imgPath)!;

      FileHelper.createNewFileSync(pat);
      FileHelper.writeBytesSync(pat, editOptions.imageBytes!);

      comp.complete(pat);
    }

    editOptions.callOnResult = onOk;
    final ov = OverlayScreenView(content: PicEditor(editOptions), backgroundColor: Colors.black);
    OverlayDialog().show(context, ov).then((value){
      if(!comp.isCompleted){
        comp.complete(null/*imgPath*/);
      }
    });

    return comp.future;
  }

  void afterUploadAvatar(String imgPath, Map map) async {
    final String? url = map[Keys.url];

    if(url == null){
      return;
    }

    user.profileModel = MediaModel()..url = url.. id = Generator.generateIntId(5);

    if(kIsWeb){
      await SessionService.sinkUserInfo(user);
      EventNotifierService.notify(AppEvents.userProfileChange);
      return;
    }

    final path = AppDirectories.getSavePathUri(url, SavePathType.userProfile, user.avatarFileName);
    final f = FileHelper.renameSyncSafe(imgPath, path!);

    user.profileModel!.path = f.path;

    hideLoading();
    AppSnack.showSnack$operationSuccess(context);

    await SessionService.sinkUserInfo(user);
    EventNotifierService.notify(AppEvents.userProfileChange);
  }

  void uploadAvatar(String filePath) {
    final partName = 'ProfileAvatar';
    final fileName = PathHelper.getFileName(filePath);

    final js = <String, dynamic>{};

    js[Keys.requesterId] = user.userId;
    js[Keys.forUserId] = user.userId;
    js[Keys.fileName] = fileName;
    js[Keys.partName] = partName;

    requester.httpRequestEvents.onFailState = (req, r) async {
      await hideLoading();
      AppSnack.showSnack$errorCommunicatingServer(context);
    };

    requester.httpRequestEvents.onStatusOk = (req, data) async {
      afterUploadAvatar(filePath, data);
    };

    requester.bodyJson = null;
    requester.httpItem.clearFormField();
    requester.httpItem.addFormField(Keys.jsonPart, JsonHelper.mapToJson(js));
    requester.httpItem.addFormFile(partName, fileName, File(filePath));

    showLoading(canBack: false);
    requester.request(context, false);
  }

  void deleteProfile(){
    AppSheet.closeSheet(context);

    final js = <String, dynamic>{};
    js[Keys.requesterId] = user.userId;
    js[Keys.forUserId] = user.userId;

    requester.httpRequestEvents.onAnyState = (req) async {
      await hideLoading();
    };

    requester.httpRequestEvents.onFailState = (req, r) async {
      AppSnack.showSnack$OperationFailed(context);
    };

    requester.httpRequestEvents.onStatusOk = (req, data) async {
      user.profileModel = null;

      EventNotifierService.notify(AppEvents.userProfileChange);
      SessionService.sinkUserInfo(user);
    };

    showLoading();
    requester.bodyJson = js;


    requester.request(context, false);
  }
  
  void uploadName(String name, String family){
    final js = <String, dynamic>{};
    js[Keys.requesterId] = user.userId;
    js[Keys.forUserId] = user.userId;
    js[Keys.name] = name;
    js[Keys.family] = family;

    requester.httpRequestEvents.onAnyState = (req) async {
      await hideLoading();
    };

    requester.httpRequestEvents.onFailState = (req, r) async {
      AppSnack.showSnack$OperationFailed(context);
    };

    requester.httpRequestEvents.onStatusOk = (req, data) async {
      user.name = name;
      user.family = family;

      assistCtr.updateHead();
      await SessionService.sinkUserInfo(user);
      AppOverlay.hideDialog(context);
      EventNotifierService.notify(AppEvents.userProfileChange);
    };

    showLoading(canBack: false);
    requester.bodyJson = js;

    requester.request(context, false);
  }

  void uploadGender(int gender){
    final js = <String, dynamic>{};
    js[Keys.requesterId] = user.userId;
    js[Keys.forUserId] = user.userId;
    js[Keys.sex] = gender;

    requester.httpRequestEvents.onAnyState = (req) async {
      await hideLoading();
    };

    requester.httpRequestEvents.onFailState = (req, r) async {
      AppSnack.showSnack$OperationFailed(context);
    };

    requester.httpRequestEvents.onStatusOk = (req, data) async {
      user.sex = gender;

      assistCtr.updateHead();
      await SessionService.sinkUserInfo(user);
      EventNotifierService.notify(AppEvents.userProfileChange);
    };

    showLoading(canBack: false);
    requester.bodyJson = js;

    requester.request(context, false);
  }

  void uploadBirthdate(DateTime dt){
    final js = <String, dynamic>{};

    js[Keys.requesterId] = user.userId;
    js[Keys.forUserId] = user.userId;
    js[Keys.date] = DateHelper.toTimestamp(dt);

    requester.httpRequestEvents.onAnyState = (req) async {
      await hideLoading();
    };

    requester.httpRequestEvents.onFailState = (req, r) async {
      AppSnack.showSnack$OperationFailed(context);
    };

    requester.httpRequestEvents.onStatusOk = (req, data) async {
      user.birthDate = dt;

      assistCtr.updateHead();
      await SessionService.sinkUserInfo(user);
      EventNotifierService.notify(AppEvents.userProfileChange);
    };

    showLoading(canBack: false);
    requester.bodyJson = js;

    requester.request(context, false);
  }

  void requestProfileData() async {
    final user = SessionService.getLastLoginUser();

    if(user == null || user.userId == '0'){
      return;
    }

    final js = <String, dynamic>{};

    js[Keys.requesterId] = user.userId;
    js[Keys.forUserId] = js[Keys.requesterId];


    requester.httpRequestEvents.onFailState = (req, r) async {
      AppToast.showToast(context, AppMessages.errorCommunicatingServer);
    };

    requester.httpRequestEvents.onStatusOk = (req, data) async {
      await SessionService.newProfileData(data as Map<String, dynamic>);

      assistCtr.updateHead();
    };

    requester.bodyJson = js;

    requester.request(context);
  }

  void checkPermission() async {
    if(user.profileModel != null && user.profileModel!.url != null){
      final hasPermission = await PermissionTools.isGrantedStoragePermission();

      if(!hasPermission) {
        final graPermission = await PermissionTools.requestStoragePermission();

        if(graPermission == PermissionStatus.granted){
          assistCtr.updateHead();
        }
      }
    }
  }
}
