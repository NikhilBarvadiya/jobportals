// ignore_for_file: invalid_use_of_protected_member
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobportals/core/helpers/common_helper.dart';
import 'package:jobportals/core/routes/app_route_names.dart';
import 'package:jobportals/view/auth/auth_service.dart';
import 'package:jobportals/view/auth/ui/login_ui.dart';
import 'package:jobportals/view/auth/ui/signup_ui.dart';
import 'package:dio/dio.dart' as dio;

class AuthCtrl extends GetxController {
  /// Login......
  TextEditingController txtMobileNumber = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  /// Register......
  TextEditingController txtName = TextEditingController();
  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtLocation = TextEditingController();
  TextEditingController txtSkill = TextEditingController();
  TextEditingController txtJobTitle = TextEditingController();
  TextEditingController txtDesc = TextEditingController();

  bool isLoading = false;
  dio.FormData selectedFileList = dio.FormData();
  AuthService authService = Get.find();
  List skillList = [];

  isLoadingStart() => isLoading = true..obs.update((val) => update());

  isLoadingStop() => isLoading = false..obs.update((val) => update());

  bool isEmploye = false;
  bool isEmployer = false;

  employerLogin(v) async {
    if (isEmployer == false) {
      isEmployer = v;
    }
    isEmploye = false;
    update();
  }

  employeLogin(v) async {
    if (isEmploye == false) {
      isEmploye = v;
    }
    isEmployer = false;
    update();
  }

  @override
  void onReady() {
    view(1, null);
    super.onReady();
  }

  Future<bool> willPopScope() async => false;

  onSkillAdd() {
    if (txtSkill.text.isNotEmpty) {
      skillList.add(txtSkill.text);
      txtSkill.clear();
    }
    update();
  }

  _cleanAtLogin() {
    txtName.text = "";
    txtMobileNumber.text = "";
    txtSkill.text = "";
    txtDesc.text = "";
    txtJobTitle.text = "";
    txtLocation.text = "";
    txtUserName.text = "";
    txtEmail.text = "";
    txtPassword.text = "";
    txtAddress.text = "";
    skillList.clear();
    update();
  }

  int? lastPage;

  lastView() => view(lastPage ?? 1, null);

  view(int next, int? prev) {
    lastPage = prev;
    switch (next) {
      case 1:
        _cleanAtLogin();
        _showBottomSheet(const LoginUI());
        break;
      case 2:
        _showBottomSheet(const SignupUI());
        break;
    }
  }

  _showBottomSheet(Widget widget) {
    if (Get.isBottomSheetOpen == true) Get.back();
    Get.bottomSheet(
      widget,
      isDismissible: false,
      enableDrag: false,
      barrierColor: Colors.black12,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      ignoreSafeArea: false,
    );
  }

  singleImageValidation(dio.FormData value) {
    selectedFileList = value;
    update();
  }

  userLogin() async {
    if (commonHelper.isMobileValidation(txtMobileNumber.text) == true && txtPassword.text != "") {
      String type = isEmploye == true ? "employee" : "employer";
      var body = {"mobile": txtMobileNumber.text, "password": txtPassword.text, "type": type};
      log(body.toString());
      isLoadingStart();
      authService.isUserLoggedIn.value = true;
      Get.toNamed(AppRouteNames.home)!.then((value) => update());
      isLoadingStop();
    } else {
      log("Something wrong?");
    }
  }

  newLogin() async {
    if (isEmploye == true) {
      Map<String, dynamic> json = {
        "txtUserName": txtUserName.text,
        "companyName": txtName.text,
        "emilId": txtEmail.text,
        "password": txtPassword.text,
        "address": txtAddress.text,
        "mobile": txtMobileNumber.text,
      };
      log(json.toString());
      isLoadingStart();
      authService.isUserLoggedIn.value = true;
      Get.toNamed(AppRouteNames.home)!.then((value) => update());
      isLoadingStop();
    } else {
      Map<String, dynamic> json = {
        "name": txtName.text,
        "location": txtLocation.text,
        "skill": skillList,
        "jobTitle": txtJobTitle.text,
        "description": txtDesc.text,
        "mobile": txtMobileNumber.text,
      };
      dio.FormData formData = dio.FormData.fromMap(json);
      if (selectedFileList.fields.isNotEmpty) {
        for (int k = 0; k < selectedFileList.fields.length; k++) {
          formData.fields.add(selectedFileList.fields[k]);
        }
      }
      formData.files.add(selectedFileList.files.first);
      isLoadingStart();
      authService.isUserLoggedIn.value = true;
      Get.toNamed(AppRouteNames.home)!.then((value) => update());
      isLoadingStop();
    }
    update();
  }
}
