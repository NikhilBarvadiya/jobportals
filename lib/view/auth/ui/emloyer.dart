import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobportals/core/constants/app_text.dart';
import 'package:jobportals/core/helpers/app_text_style/app_css.dart';
import 'package:jobportals/core/helpers/decoration.dart';
import 'package:jobportals/core/theme/light.dart';
import 'package:jobportals/view/auth/auth_ctrl.dart';
import 'package:jobportals/widgets/custom_textBox.dart';
import 'package:jobportals/widgets/document_picker.dart';

class EmployerUI extends StatelessWidget {
  const EmployerUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top;
    return GetBuilder<AuthCtrl>(
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: decoration.singleBorderRadius([1, 2], 8.0),
        ),
        padding: const EdgeInsets.only(bottom: 50),
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
                      "Create employer account",
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
                    hintText: AppText.name,
                    keyboardType: TextInputType.text,
                  ).paddingOnly(bottom: 15),
                  CustomTextBox(
                    controller: _.txtLocation,
                    hintText: "Location",
                    keyboardType: TextInputType.text,
                  ).paddingOnly(bottom: 15),
                  CustomTextBox(
                    controller: _.txtSkill,
                    hintText: "Skill",
                    onEditingComplete: () => _.onSkillAdd(),
                  ).paddingOnly(bottom: 15),
                  if (_.skillList.isNotEmpty)
                    Card(
                      elevation: 0,
                      color: const Color(0xFFf3f5f7).withOpacity(0.5),
                      child: Container(
                        constraints: BoxConstraints(maxHeight: Get.height * 0.35),
                        child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const ClampingScrollPhysics(),
                          children: [
                            for (int i = 0; i < _.skillList.length; i++)
                              ListTile(
                                title: Text(
                                  _.skillList[i].toString().capitalizeFirst.toString(),
                                  style: AppCss.footnote.copyWith(fontSize: 13),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    _.skillList.removeAt(i);
                                    _.update();
                                  },
                                  icon: const Icon(Icons.clear, color: Colors.red, size: 18),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ).paddingOnly(bottom: 15),
                  CustomTextBox(
                    controller: _.txtJobTitle,
                    hintText: "Job title",
                    keyboardType: TextInputType.text,
                  ).paddingOnly(bottom: 15),
                  CustomTextBox(
                    controller: _.txtDesc,
                    hintText: "Description",
                    keyboardType: TextInputType.text,
                  ).paddingOnly(bottom: 15),
                  CustomTextBox(
                    controller: _.txtMobileNumber,
                    hintText: AppText.mobileHint,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                  ).paddingOnly(bottom: 15),
                  DocumentPicker(
                    title: AppText.profile,
                    image: (value) => _.singleImageValidation(value),
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
