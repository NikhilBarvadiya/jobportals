import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobportals/core/constants/app_assets.dart';
import 'package:jobportals/core/helpers/app_text_style/app_css.dart';
import 'package:jobportals/core/theme/light.dart';
import 'package:jobportals/view/splash/splash_ctrl.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashCtrl>(
      init: SplashCtrl(),
      builder: (_) => Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.logo, height: 100, width: 100, colorBlendMode: BlendMode.screen),
                  SizedBox(
                    height: Sizes.s20,
                    width: Sizes.s20,
                    child: CircularProgressIndicator(strokeWidth: 3, color: lightColorScheme.secondary),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 10),
              child: Text(
                _.appVersion != "" ? "v${_.appVersion}" : "v1.0.0",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
