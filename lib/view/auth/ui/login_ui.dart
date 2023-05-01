import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobportals/core/constants/app_text.dart';
import 'package:jobportals/core/helpers/app_text_style/app_css.dart';
import 'package:jobportals/widgets/custom_textBox.dart';
import 'package:jobportals/widgets/rounded_button.dart';
import '../auth_ctrl.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthCtrl>(
      builder: (_) {
        return WillPopScope(
          onWillPop: (() async => false),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          value: _.isEmploye,
                          onChanged: (value) => _.employeLogin(value),
                        ),
                        Text("Employee", style: AppCss.h1),
                      ],
                    ),
                    const SizedBox(width: 15),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          value: _.isEmployer,
                          onChanged: (value) => _.employerLogin(value),
                        ),
                        Text("Employer", style: AppCss.h1)
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FlutterLogo(size: 80).paddingOnly(bottom: 10),
                    const Text(
                      AppText.enterMobileNumber,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ).paddingOnly(bottom: 10),
                    Text(
                      AppText.loginDescription,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade500,
                      ),
                    ).paddingOnly(bottom: 25),
                    CustomTextBox(
                      controller: _.txtMobileNumber,
                      hintText: AppText.mobileHint,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                    ).paddingOnly(bottom: 25),
                    CustomTextBox(
                      controller: _.txtPassword,
                      hintText: "Password",
                    ).paddingOnly(bottom: 25),
                    RoundedButton(
                      onTap: () => _.userLogin(),
                      text: AppText.btn,
                      isLoading: _.isLoading,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("${AppText.signUpNote} "),
                        InkWell(
                          onTap: () => _.view(2, null),
                          child: const Text(
                            AppText.signUp,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ).paddingOnly(top: 2),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
