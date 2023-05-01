import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobportals/core/constants/app_assets.dart';
import 'package:jobportals/view/auth/auth_ctrl.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthCtrl>(
      init: AuthCtrl(),
      builder: (_) => WillPopScope(
        onWillPop: _.willPopScope,
        child: Scaffold(
          body: Stack(
            children: [
              Image.asset(AppAssets.appBackground, height: Get.height, width: Get.width, fit: BoxFit.cover),
            ],
          ),
        ),
      ),
    );
  }
}
