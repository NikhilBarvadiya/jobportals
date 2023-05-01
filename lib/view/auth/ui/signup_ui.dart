// ignore_for_file: unrelated_type_equality_checks
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:jobportals/core/constants/app_text.dart';
import 'package:jobportals/core/theme/light.dart';
import 'package:jobportals/view/auth/auth_ctrl.dart';
import 'package:jobportals/view/auth/ui/emloyer.dart';
import 'package:jobportals/view/auth/ui/employe.dart';
import 'package:jobportals/widgets/rounded_button.dart';

class SignupUI extends StatefulWidget {
  const SignupUI({super.key});

  @override
  State<SignupUI> createState() => _SignupUIState();
}

class _SignupUIState extends State<SignupUI> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthCtrl>(
      builder: (_) {
        return KeyboardVisibilityBuilder(
          builder: (context, isKeyboardVisible) {
            return WillPopScope(
              onWillPop: () async {
                _.view(1, null);
                return false;
              },
              child: Stack(
                children: [
                  if (_.isEmploye == true) const EmployeUI(),
                  if (_.isEmployer == true) const EmployerUI(),
                  if (!isKeyboardVisible)
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RoundedButton(
                            onTap: () => _.newLogin(),
                            text: AppText.btn,
                            isLoading: _.isLoading,
                            color: lightColorScheme.primary,
                          ).paddingAll(20),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
