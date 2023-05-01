import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobportals/core/helpers/storage_helper.dart';
import 'package:jobportals/core/routes/app_route_names.dart';
import 'package:jobportals/view/auth/auth_ctrl.dart';

class HomeCtrl extends GetxController {
  int selectedIndex = 0;

  onItemTapped(i) {
    selectedIndex = i;
    update();
  }

  List<Widget> pages = [
    Container(color: Colors.red),
    Column(
      children: [
        MaterialButton(
          onPressed: () {
            clearStorage();
            Get.offNamedUntil(AppRouteNames.auth, (Route<dynamic> route) => false);
            Get.put(AuthCtrl(), permanent: true).onReady();
          },
          child: const Text("Logout"),
        ),
      ],
    ),
  ];
}
