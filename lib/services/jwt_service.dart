import 'dart:async';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:app/managers/api_manager.dart';
import 'package:app/managers/settings_manager.dart';
import 'package:app/services/session_service.dart';
import 'package:app/structures/models/user_model.dart';
import 'package:app/tools/app/app_broadcast.dart';
import 'package:app/tools/app/app_http_dio.dart';
import 'package:app/tools/app/app_toast.dart';
import 'package:app/tools/route_tools.dart';

class JwtService {
  JwtService._();
  static Timer? _refreshTimer;
  static Duration _refreshDuration = Duration(minutes: 1);

  static void runRefreshService(){
    if(!iaRefreshServiceRun()) {
      _refreshTimer = Timer.periodic(_refreshDuration, (t){
        _refreshDuration = Duration(minutes: 10/*SettingsManager.globalSettings.expiryMinutes*/);
        final user = SessionService.getLastLoginUser();

        if(user != null) {
          requestNewToken(user);
        }
      });
    }
  }

  static void stopRefreshService(){
    _refreshTimer?.cancel();
  }

  static bool iaRefreshServiceRun(){
    return _refreshTimer != null && _refreshTimer!.isActive;
  }

  static Map decodeToken(String token){
    return JwtDecoder.decode(token);
  }

  static bool isExpired(String token){
    return JwtDecoder.isExpired(token);
  }

  static Duration getTokenTime(String token){
    return JwtDecoder.getTokenTime(token);
  }

  static DateTime getExpirationDate(String token){
    return JwtDecoder.getExpirationDate(token);
  }

  static String sign(Map payload, JWTKey key /*SecretKey('secret passphrase')*/,{
    String? issuer,
    String? jwtId,
    JWTAlgorithm algorithm = JWTAlgorithm.RS256,
  }){

    final jwt = JWT(
      payload,
      jwtId: jwtId,
      issuer: issuer,
    );

    return jwt.sign(key, algorithm: algorithm);
  }

  static JWT? verify(String token, JWTKey key ,{
    bool checkHeader = false,
  }){

    try {
      return JWT.verify(token, key,
          checkHeaderType: checkHeader,
      );
    }
    catch (ex) {/**/}

    return null;
  }

  static bool refreshTokenIsOk(String? rToken){
    if(rToken == null){
      return false;
    }

    return !isExpired(rToken);
  }

  static bool accessTokenIsOk(String? accessToken){
    if(accessToken == null){
      return false;
    }

    return !isExpired(accessToken);
  }

  static Future<bool> requestNewToken(UserModel um) async {
    final js = <String, dynamic>{};
    js['accessToken'] = um.token?.token;
    js['refreshToken'] = um.token?.refreshToken;

    final r = HttpItem();
    r.fullUrl = '${ApiManager.serverApi}/updateToken';
    r.method = 'PUT';
    r.body = js;
    r.headers['accept'] = 'application/json';
    r.headers['Content-Type'] = 'application/json';

    final a = AppHttpDio.send(r);
    await a.response;

    if(a.responseData?.statusCode == 200){
      final dataJs = a.getBodyAsJson()!;
      um.token?.token = dataJs['data'];
      SessionService.sinkUserInfo(um);

      if(!iaRefreshServiceRun()){
        runRefreshService();
      }

      return true;
    }

    else if(a.responseData?.statusCode == 422){
      final dataJs = a.getBodyAsJson()!;
      final message = dataJs['message'];

      AppToast.showToast(RouteTools.getBaseContext()!, message);

      await SessionService.logoff(um.userId);
      AppBroadcast.reBuildMaterial();

      RouteTools.backToRoot(RouteTools.getTopContext()!);
    }

    else if(a.responseData?.statusCode == 307){
      final dataJs = a.getBodyAsJson()!;
      final message = dataJs['message'];

      AppToast.showToast(RouteTools.getBaseContext()!, message);

      await SessionService.logoff(um.userId);
      AppBroadcast.reBuildMaterial();

      RouteTools.backToRoot(RouteTools.getTopContext()!);
    }
    else if(a.responseData?.statusCode == 405){
      AppToast.showToast(RouteTools.getBaseContext()!, 'need to config');
    }

    return false;
  }
}
