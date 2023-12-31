import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:iris_tools/net/trustSsl.dart';

import 'package:app/managers/settings_manager.dart';
import 'package:app/managers/splash_manager.dart';
import 'package:app/managers/version_manager.dart';
import 'package:app/services/download_upload_service.dart';
import 'package:app/services/login_service.dart';
import 'package:app/services/native_call_service.dart';
import 'package:app/services/session_service.dart';
import 'package:app/structures/abstract/state_super.dart';
import 'package:app/system/application_signal.dart';
import 'package:app/tools/app/app_broadcast.dart';
import 'package:app/tools/app/app_cache.dart';
import 'package:app/tools/app/app_db.dart';
import 'package:app/tools/app/app_images.dart';
import 'package:app/tools/app/app_locale.dart';
import 'package:app/tools/app/app_notification.dart';
import 'package:app/tools/app/app_themes.dart';
import 'package:app/tools/device_info_tools.dart';
import 'package:app/tools/log_tools.dart';
import 'package:app/tools/route_tools.dart';
import 'package:app/views/baseComponents/route_dispatcher.dart';
import 'package:app/views/baseComponents/splash_widget.dart';
import 'package:app/views/states/waitToLoad.dart';

class SplashPage extends StatefulWidget {
  SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}
///======================================================================================================
class SplashPageState extends StateSuper<SplashPage> {
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    splashWaitTimer();
    startInit();

    if (SplashManager.mustWaitInSplash()) {
      //System.hideBothStatusBarOnce();
      return getSplashView();
    }
    else {
      return getRoutePage();
    }
  }

  Widget getSplashView() {
    if(kIsWeb){
      return const WaitToLoad();
    }

    return const SplashView();
  }

  Widget getRoutePage(){
    if(kIsWeb && !SplashManager.isFullInitialOk){
      return const SizedBox();
    }

    return RouteDispatcher.dispatch();
  }

  void splashWaitTimer() async {
    final dur = Duration(milliseconds: SplashManager.splashWaitingMil);

    if(SplashManager.mustWaitToSplashTimer && timer == null){
      timer = Timer(dur, (){
        SplashManager.mustWaitToSplashTimer = false;
        timer = null;

        if(context.mounted){
          callState();
        }
      });
    }
  }

  void startInit() async {
    if (SplashManager.isFirstInitOk) {
      return;
    }

    SplashManager.isFirstInitOk = true;

    await appInitial(context);
    final settingsLoad = SettingsManager.loadSettings();

    if (settingsLoad) {
      appLazyInit();
      await SessionService.fetchLoginUsers();
      await VersionManager.checkVersionOnLaunch();
      connectToServer();

      SplashManager.isInLoadingSettings = false;
      AppBroadcast.reBuildMaterialBySetTheme();
    }
  }

  void connectToServer() async {
    /*final serverData = await SettingsManager.requestGlobalSettings();

    if (serverData == null) {
      AppSheet.showSheetOneAction(
        RouteTools.materialContext!,
        AppMessages.errorCommunicatingServer,
        onButton: () {
          SplashManager.gotoSplash();
          connectToServer();
        },
        buttonText: AppMessages.tryAgain,
        isDismissible: false,
      );
    }
    else {
      SplashManager.isConnectToServer = true;

      SessionService.fetchLoginUsers();

      if(context.mounted){
        callState();
      }
    }*/
  }

  static Future<void> appInitial(BuildContext? context) async {
    try {
      await AppDB.init();
      AppThemes.init();
      await AppLocale.init();
      await DeviceInfoTools.prepareDeviceInfo();
      await DeviceInfoTools.prepareDeviceId();
      TrustSsl.acceptBadCertificate();
      //AudioPlayerService.init();

      if (!kIsWeb) {
      	await AppNotification.initial();
        AppNotification.startListenTap();
      }

      if(context != null && context.mounted){
        RouteTools.prepareRoutes();
        AppCache.screenBack = const AssetImage(AppImages.backgroundPlus);
        await precacheImage(AppCache.screenBack!, context);
      }

      SplashManager.isFullInitialOk = true;
    }
    catch (e){
      LogTools.logger.logToAll('error in appInitial >> $e');
    }

    return;
  }

  static Future<void> appLazyInit() {
    final c = Completer<void>();

    if (SplashManager.callLazyInit) {
      c.complete();
      return c.future;
    }

    SplashManager.callLazyInit = true;

    Timer.periodic(const Duration(milliseconds: 50), (Timer timer) async {
      if (SplashManager.isFullInitialOk) {
        timer.cancel();
        await _lazyInitCommands();
        c.complete();
      }
    });

    return c.future;
  }

  static Future<void> _lazyInitCommands() async {
    try {
      //WakeupService.init();
      NativeCallService.init();
      NativeCallService.assistanceBridge!.invokeMethod('setAppIsRun');

      ApplicationSignal.start();
      SettingsManager.init();
      LoginService.init();
      DownloadUploadService.init();
      SettingsManager.requestGlobalSettings();
      //await FireBaseService.start();

      /*if (System.isWeb()) {
        void onSizeCheng(oldW, oldH, newW, newH) {
          AppDialogIris.prepareDialogDecoration();
        }

        AppSizes.instance.addMetricListener(onSizeCheng);
      }*/

      if(RouteTools.materialContext != null) {
        //VersionManager.checkAppHasNewVersion(RouteTools.materialContext!);
      }
    }
    catch (e){
      SplashManager.callLazyInit = false;
      LogTools.logger.logToAll('error in lazyInitCommands >> $e');
    }
  }
}
