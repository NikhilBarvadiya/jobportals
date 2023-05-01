import 'dart:developer';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobportals/core/routes/app_route_names.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionCtrl extends GetxController {
  @override
  void onInit() {
    loadPermissionStatus();
    super.onInit();
  }

  List permissionList = [
    {
      "icon": Icons.storage,
      "hasPermission": false,
      "title": "Storage",
      "description": "This app will use storage, in order to read images from external storage and write app data."
    },
    {
      "icon": Icons.location_on,
      "hasPermission": false,
      "title": "Location",
      "description":
          "This app will collect location data to enable tracking of your trips to work and calculate distance travelled, even when app is closed."
    },
    {
      "icon": Icons.camera,
      "hasPermission": false,
      "title": "Camera",
      "description": "This app will use camera, to take images of parcels and packages."
    },
    {
      "icon": Icons.mic,
      "hasPermission": false,
      "title": "Microphone",
      "description": "This app will use microphone, to take audio instructions from you regarding orders."
    },
  ];

  get appTheme => null;
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  void authCheck() async {
    Get.toNamed(AppRouteNames.home);
  }

  onTap(String clickedOn) async {
    if (clickedOn == "askForPermission") {
      var deviceInfo = await deviceInfoPlugin.androidInfo;
      if (double.parse(deviceInfo.data["version"]["release"]) > 12) {
        Map<Permission, PermissionStatus> permissionStatus = await [
          Permission.manageExternalStorage,
          Permission.camera,
          Permission.location,
          Permission.microphone,
        ].request();
        log(permissionStatus.toString());
        await loadPermissionStatus();
        if (permissionList[0]["hasPermission"] && permissionList[1]["hasPermission"]) {
          authCheck();
        } else {
          // warningToast("You didn't provide some of permissions!");
        }
      } else {
        Map<Permission, PermissionStatus> permissionStatus = await [
          Permission.storage,
          Permission.camera,
          Permission.location,
          Permission.microphone,
        ].request();
        log(permissionStatus.toString());
        await loadPermissionStatus();
        if (permissionList[0]["hasPermission"] && permissionList[1]["hasPermission"]) {
          authCheck();
        } else {
          // warningToast("You didn't provide some of permissions!");
        }
      }
    } else {
      authCheck();
    }
    update();
  }

  loadPermissionStatus() async {
    var deviceInfo = await deviceInfoPlugin.androidInfo;
    if (double.parse(deviceInfo.data["version"]["release"]) > 12) {
      permissionList[0]["hasPermission"] = await Permission.manageExternalStorage.isGranted;
    } else {
      permissionList[0]["hasPermission"] = await Permission.storage.isGranted;
    }
    permissionList[1]["hasPermission"] = await Permission.microphone.isGranted;
    update();
  }
}
