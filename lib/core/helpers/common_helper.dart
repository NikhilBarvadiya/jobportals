import 'dart:io';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jobportals/core/routes/app_route_names.dart';
import 'package:jobportals/core/theme/light.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonHelper {
  void launchURL(String val) async {
    if (await canLaunchUrl(Uri.parse(val))) {
      await launchUrl(Uri.parse(val));
    } else {
      throw 'Could not launch $val';
    }
  }

  snack(context, String message, Color color) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.fixed,
      backgroundColor: color,
      content: Text(message),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  Future<File?> pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      XFile? pickedFile = await picker.pickImage(
        source: source,
        preferredCameraDevice: CameraDevice.front,
        maxHeight: 1080,
        maxWidth: 1080,
      );
      return pickedFile != null ? File(pickedFile.path) : null;
    } catch (e) {
      return null;
    }
  }

  Future<File?> cropImageByPath(String imagePath, context) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      cropStyle: CropStyle.circle,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: lightColorScheme.primary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(title: 'Cropper'),
      ],
    );
    return croppedFile != null ? File(croppedFile.path) : null;
  }

  Future<bool> isNetworkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    }
  }

  goToNoInternetScreen() {
    String currentRoute = Get.currentRoute;
    if (currentRoute != AppRouteNames.noInternet) {
      Get.toNamed(AppRouteNames.noInternet);
    }
  }

  bool isMobileValidation(String phoneNumber) {
    String regexPattern = r'^[6-9][0-9]{9}$';
    var regExp = RegExp(regexPattern);
    if (phoneNumber.isEmpty) {
      return false;
    } else if (regExp.hasMatch(phoneNumber)) {
      return true;
    }
    return false;
  }

  bool isVehicleValidation(String phoneNumber) {
    String regexPattern = r'^[A-Z]{2}[\\ -]{0,1}[0-9]{2}[\\ " "-]{0,1}[A-Z]{1,2}[\\ -]{0,1}[0-9]{4}$';
    var regExp = RegExp(regexPattern);
    if (phoneNumber.isEmpty) {
      return false;
    } else if (regExp.hasMatch(phoneNumber)) {
      return true;
    }
    return false;
  }

  String getFormattedDate(String dtStr) {
    var dt = DateTime.parse(dtStr).toUtc().toLocal();
    return "${dt.day.toString().padLeft(2, '0')}-${dt.month.toString().padLeft(2, '0')}-${dt.year}";
  }

  String getFormattedTime(String dtStr) {
    var dt = DateFormat("hh:mm a").format(DateTime.parse(dtStr).toLocal());
    return dt;
  }

  String getFormattedDateTimer(String dtStr) {
    var date = DateFormat('dd MMM yyyy', 'en_US').format(DateTime.parse(dtStr)).toString();
    var time = DateFormat("hh:mm a").format(DateTime.parse(dtStr).toLocal());
    return "$date\t$time";
  }

  String getFormattedFilterDate(String dtStr) {
    return DateFormat('dd MMM yyyy', 'en_US').format(DateTime.parse(dtStr)).toString();
  }

  connectAdmin() {
    String link = "tel:6357017016";
    launchURL(link);
  }

  connectEmail() {
    final Uri params = Uri(scheme: 'mailto', path: 'contact@fastwhistle.com');
    try {
      launchUrl(params);
    } catch (err) {
      throw "Cant launch";
    }
  }

  connectFacebook() {
    String link = "https://www.facebook.com/Fastwhistle/";
    commonHelper.launchURL(link);
  }

  connectWhatsapp() {
    String link = "whatsapp://send?phone=916357017016";
    launchURL(link);
  }

  datePicker() {
    var config = CalendarDatePicker2WithActionButtonsConfig(calendarType: CalendarDatePicker2Type.range);
    List<DateTime?> selectedDate = [];
    return CalendarDatePicker2WithActionButtons(
      config: config,
      value: [DateTime.now(), DateTime.now().add(const Duration(days: 1))],
      onValueChanged: (values) async {
        selectedDate = values;
        var from = '${selectedDate[0]!.year}-${selectedDate[0]!.month.toString().padLeft(2, '0')}-${selectedDate[0]!.day.toString().padLeft(2, '0')}';
        var to = '${selectedDate[1]!.year}-${selectedDate[1]!.month.toString().padLeft(2, '0')}-${selectedDate[1]!.day.toString().padLeft(2, '0')}';
        var json = {"from": from, "to": to};
        Get.back(result: json);
      },
      onCancelTapped: () {
        Get.back();
      },
    );
  }
}

CommonHelper commonHelper = CommonHelper();
