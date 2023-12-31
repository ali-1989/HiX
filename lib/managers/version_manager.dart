import 'dart:async';

import 'package:flutter/material.dart';

import 'package:iris_tools/api/helpers/mathHelper.dart';

import 'package:app/structures/models/settings_model.dart';
import 'package:app/structures/models/version_model.dart';
import 'package:app/system/constants.dart';
import 'package:app/tools/app/app_db.dart';
import 'package:app/tools/app/app_themes.dart';
import 'package:app/tools/route_tools.dart';
import 'package:app/views/pages/new_version_page.dart';
import '/managers/settings_manager.dart';

class VersionManager {
  VersionManager._();

  static bool existNewVersion = false;
  static VersionModel? newVersionModel;

  static Future<void> onFirstInstall() async {
    SettingsManager.localSettings.currentVersion = Constants.appVersionCode;

    await AppDB.firstLaunch();
    AppThemes.prepareFonts(SettingsManager.localSettings.appLocale.languageCode);
    SettingsManager.saveSettings();
  }

  static Future<void> onInstallNewVersion() async {
    SettingsManager.localSettings.currentVersion = Constants.appVersionCode;
    SettingsManager.localSettings.httpAddress = SettingsModel.defaultHttpAddress;
    SettingsManager.saveSettings();
  }

  static Future<void> checkVersionOnLaunch() async {
    final oldVersion = SettingsManager.localSettings.currentVersion;

    if (oldVersion == null) {
      onFirstInstall();
    }
    else if (oldVersion != Constants.appVersionCode) {
      onInstallNewVersion();
    }
  }

  /*static Future<VersionModel?> requestGetLastVersion(BuildContext context, Map<String, dynamic> data) async {
    final res = Completer<VersionModel?>();
    final requester = Requester();

    requester.httpRequestEvents.onAnyState = (req) async {
      requester.dispose();
    };

    requester.httpRequestEvents.onFailState = (req, response) async {
      res.complete(null);
    };

    requester.httpRequestEvents.onStatusOk = (req, data) async {
      newVersionModel = VersionModel.fromMap(data);

      res.complete(newVersionModel);
    };

    data[Keys.requestZone] = 'last_version';

    requester.bodyJson = data;
    requester.prepareUrl(pathUrl: '');
    requester.request(context, false);

    return res.future;
  }*/

  /*static void checkAppHasNewVersion(BuildContext context) async {
    final deviceInfo = DeviceInfoTools.mapDeviceInfo();

    final vm = await requestGetLastVersion(context, deviceInfo);

    if(vm != null){
      if(vm.newVersionCode > Constants.appVersionCode){
        if(!vm.restricted && AppDB.fetchKv('promptVersion_${vm.newVersionCode}') != null){
          return;
        }

        existNewVersion = true;
        AppDB.setReplaceKv('promptVersion_${vm.newVersionCode}', true);

        await Future.delayed(const Duration(seconds: 4));

        if(context.mounted && !kIsWeb) {
          showUpdateDialog(context, vm);
        }
      }
    }
  }*/

  static void checkAppHasNewVersion(BuildContext context, VersionModel serverVersion) async {
    var v = serverVersion.newVersionName;
    v = v.replaceAll('.', '');

    if(MathHelper.toInt(v) > Constants.appVersionCode){
      existNewVersion = true;
      showUpdateDialog(context, serverVersion);
    }
  }

  static void showUpdateDialog(BuildContext context, VersionModel vm) {
    RouteTools.pushPage(context, NewVersionPage(versionModel: vm));
    /*void closeApp(ctx){
      System.exitApp();
    }

    final decoration = AppDialogIris.instance.dialogDecoration.copy();

    if(vm.restricted) {
      decoration.positiveButtonBackColor = Colors.orange;
    }
    else {
      decoration.positiveButtonBackColor = Colors.grey;
    }

    AppDialogIris.instance.showIrisDialog(
      context,
      descView: _buildView(vm),
      decoration: decoration,
      yesText: vm.restricted ? AppMessages.exit : AppMessages.later,
      yesFn: vm.restricted ? closeApp: null,
    );*/
  }

  /*static Widget _buildView(VersionModel vm){
    final msg = vm.description?? AppMessages.newAppVersionIsOk;

    void onDirectClick(){
      UrlHelper.launchLink(vm.directLink?? '');

      if(!vm.restricted){
        Navigator.of(RouteTools.getBaseContext()!).pop();
      }
    }

    final views = <Widget>[];

    views.add(
        Align(
          alignment: Alignment.topLeft,
          child: CustomCard(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            color: Colors.green,
            radius: 12,
            child: Text('version: ${vm.newVersionName}', style: const TextStyle(color: Colors.white),),
          ),
        )
    );

    views.add(Text(msg));

    if (vm.directLink != null) {
      views.add(const SizedBox(height: 20));

      views.add(
          RichText(
            text: TextSpan(
              children: [
                const WidgetSpan(
                    child: Icon(AppIcons.downloadFile, size: 20, color: Colors.red,)
                ),

                TextSpan(
                  text: AppMessages.directDownload,
                  style: const TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = onDirectClick,
                ),
              ],
              style: const TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = onDirectClick,
            ),
          ),
      );
    }

    if (vm.directLink != null) {
      views.add(const SizedBox(height: 5));

      for(final market in vm.markets.entries){
        views.add(
            RichText(
                text: TextSpan(
                  text: market.key,
                  style: const TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()..onTap = (){
                    UrlHelper.launchLink(market.value);

                    if(!vm.restricted){
                      Navigator.of(RouteTools.getBaseContext()!).pop();
                    }
                    },
                )
            )
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: views,
    );
  }*/
}
