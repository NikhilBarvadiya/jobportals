// ignore_for_file: invalid_use_of_protected_member
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:jobportals/core/routes/app_route_names.dart';
import 'package:jobportals/view/auth/auth_service.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashCtrl extends GetxController {
  String appVersion = "";
  AuthService authService = Get.find();

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 2), () async {
      _authCheck();
    });
    super.onInit();
  }

  _authCheck() async {
    bool hasPermissionFirst = await getPermissionStatus();
    bool hasPermissionSecond = await getOtherPermissionStatus();
    if (hasPermissionFirst && hasPermissionSecond) {
      _authValidation();
    } else {
      Get.toNamed(AppRouteNames.prominent);
    }
  }

  Future<bool> getPermissionStatus() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    var deviceInfo = await deviceInfoPlugin.androidInfo;
    if (double.parse(deviceInfo.data["version"]["release"]) > 12) {
      return await Permission.manageExternalStorage.isGranted;
    } else {
      return await Permission.storage.isGranted;
    }
  }

  Future<bool> getOtherPermissionStatus() async {
    bool locationState = await Permission.location.isGranted;
    bool cameraState = await Permission.camera.isGranted;
    bool microphoneState = await Permission.microphone.isGranted;
    if (locationState && cameraState && microphoneState) {
      return true;
    } else {
      return false;
    }
  }

  Future _authValidation() async {
    if (authService.userData != null && authService.userData['_id'] != null) {
      String uid = authService.userData['_id'].toString();
      if (uid != "null" && uid != "") {
        Get.toNamed(AppRouteNames.home);
      } else {
        Get.toNamed(AppRouteNames.auth);
      }
    } else {
      Get.toNamed(AppRouteNames.auth);
    }
  }
}
