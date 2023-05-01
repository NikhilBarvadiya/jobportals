import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobportals/core/constants/app_text.dart';
import 'package:jobportals/core/helpers/decoration.dart';
import 'package:jobportals/core/theme/light.dart';
import 'package:jobportals/view/auth/auth_ctrl.dart';
import 'package:jobportals/widgets/custom_textBox.dart';

class EmployeUI extends StatelessWidget {
  const EmployeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top;
    return GetBuilder<AuthCtrl>(
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: decoration.singleBorderRadius([1, 2], 8.0),
        ),
        child: ListView(
          padding: EdgeInsets.only(left: 20, right: 20, top: topPadding + 10, bottom: 20),
          physics: const ClampingScrollPhysics(),
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => _.view(1, null),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: decoration.allBorderRadius(4.0),
                      boxShadow: kElevationToShadow[1],
                    ),
                    child: const Icon(Icons.arrow_back, size: 20),
                  ),
                ).paddingOnly(right: 15),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Create employee account",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      AppText.createAllValidation,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ],
            ).paddingOnly(bottom: 20),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 15),
              child: Text(
                AppText.personalInformation,
                style: TextStyle(
                  fontSize: 18,
                  color: lightColorScheme.secondary.withOpacity(.8),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: [
                  CustomTextBox(
                    controller: _.txtName,
                    hintText: "Company Name",
                    keyboardType: TextInputType.text,
                  ).paddingOnly(bottom: 15),
                  CustomTextBox(
                    controller: _.txtUserName,
                    hintText: "User Name",
                  ).paddingOnly(bottom: 15),
                  CustomTextBox(
                    controller: _.txtEmail,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Email id",
                  ).paddingOnly(bottom: 15),
                  CustomTextBox(
                    controller: _.txtPassword,
                    hintText: "Password",
                  ).paddingOnly(bottom: 15),
                  CustomTextBox(
                    controller: _.txtAddress,
                    hintText: "Address",
                    maxLines: 4,
                  ).paddingOnly(bottom: 15),
                  CustomTextBox(
                    controller: _.txtMobileNumber,
                    hintText: AppText.mobileHint,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                  ).paddingOnly(bottom: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
