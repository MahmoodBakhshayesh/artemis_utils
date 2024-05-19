import 'dart:io';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceUtility {
  DeviceUtility._();

  static Future<MyDeviceInfo> getInfo() async {
    // ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String company = "Unknown";
    String deviceModel = "Unknown";
    String osVersion = "Unknown";
    String versionNumber = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    String deviceKey = "Unknown";
    String deviceType = "Unknown";
    // ScreenType screenType = ScreenType.phone;

    if(kIsWeb){
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      company = webBrowserInfo.vendor??'Unknown';
      deviceModel = webBrowserInfo.browserName.name;
      osVersion = webBrowserInfo.product??"Unknown";
      deviceKey =webBrowserInfo.productSub??"Unknow";
      deviceType = "Web Browser";
      buildNumber = buildNumber;

    }else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      company = androidInfo.manufacturer.toString().toUpperCase();
      deviceModel = androidInfo.model.toString().toUpperCase();
      osVersion = androidInfo.version.release!;
      deviceKey = androidInfo.id!;
      buildNumber = buildNumber;

      deviceType = "Android";
    } else if (Platform.isIOS){
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      company = "APPLE";
      deviceModel = iosInfo.utsname.machine.toString().toUpperCase();
      osVersion = iosInfo.systemVersion!;
      deviceKey = iosInfo.identifierForVendor!;
      buildNumber = buildNumber;

      deviceType = "Iphone";
    } else if (Platform.isWindows){
      WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
      company = "Microsoft";
      deviceModel = "Unknown";
      osVersion = "Unknown";
      buildNumber = buildNumber;

      deviceKey = windowsInfo.computerName;
      deviceType = "Windows";
    }else if(Platform.isMacOS){
      MacOsDeviceInfo macInfo = await deviceInfo.macOsInfo;
      company = "APPLE";
      deviceModel = macInfo.model;
      osVersion = macInfo.osRelease;
      deviceKey = macInfo.computerName;
      deviceType = "Mac";
      buildNumber = buildNumber;

    }

    return MyDeviceInfo(
        company: company,
        deviceModel: deviceModel,
        osVersion: osVersion,
        deviceType: deviceType,
        deviceKey: deviceKey,
        buildNumber: buildNumber,
        versionNumber: versionNumber
    );





  }

  static Future<String> getVersionKey() async{
    PackageInfo info = await PackageInfo.fromPlatform();
    String versionKey = Platform.isAndroid ? info.buildNumber : info.version.replaceAll(".", "") + "${info.buildNumber}";
    return versionKey;
  }

  static Future<String> getVersionBuild() async{
    PackageInfo info = await PackageInfo.fromPlatform();
    String buildNumber = (!Platform.isAndroid) ? info.buildNumber : info.buildNumber.replaceFirst(info.version.replaceAll(".", ""), "");
    return buildNumber;
  }

}

class MyDeviceInfo {
  final String company;
  final String deviceModel;
  final String osVersion;
  final String versionNumber;
  final String buildNumber;
  final String deviceKey;
  final String deviceType;

  MyDeviceInfo({
    this.company="Unknown",
    this.deviceModel="Unknown",
    this.osVersion="Unknown",
    this.versionNumber="Unknown",
    this.buildNumber="Unknown",
    this.deviceKey="Unknown",
    this.deviceType="Unknown",
  });


  Map<String, dynamic> toJson() => {
    "Company": company,
    "DeviceModel": deviceModel,
    "OsVersion": osVersion,
    "VersionNumber": versionNumber,
    "DeviceKey": deviceKey,
    "DeviceType": deviceType,
    "BuildNumber": buildNumber,
  };



}

// enum ScreenType {
//   phone,
//   tablet,
//   desktop
// }
