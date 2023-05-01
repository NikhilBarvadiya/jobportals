import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobportals/core/constants/app_text.dart';
import 'package:jobportals/view/permission/permission_ctrl.dart';

class PermissionView extends StatefulWidget {
  const PermissionView({Key? key}) : super(key: key);

  @override
  State<PermissionView> createState() => _PermissionViewState();
}

class _PermissionViewState extends State<PermissionView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GetBuilder<PermissionCtrl>(
        init: PermissionCtrl(),
        builder: (controller) => Scaffold(
          body: Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 10),
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            AppText.permissionTitle,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            AppText.permissionNeed,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    for (int i = 0; i < controller.permissionList.length; i++)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Row(
                          children: [
                            Icon(controller.permissionList[i]["icon"], color: Colors.black),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        controller.permissionList[i]["title"],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        child: Icon(
                                          controller.permissionList[i]["hasPermission"] ? Icons.check_circle : Icons.circle,
                                          size: 16,
                                          color: controller.permissionList[i]["hasPermission"] ? Colors.green : Colors.redAccent,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    controller.permissionList[i]["description"],
                                    textAlign: TextAlign.justify,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CupertinoButton(
                        onPressed: () => controller.onTap("askForPermission"),
                        padding: EdgeInsets.zero,
                        child: Container(
                          width: Get.width,
                          height: 45,
                          alignment: FractionalOffset.center,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            AppText.allow,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () => controller.onTap("noThanks"),
                        padding: EdgeInsets.zero,
                        child: Container(
                          width: Get.width,
                          height: 45,
                          alignment: FractionalOffset.center,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            AppText.noThanks,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 15,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
