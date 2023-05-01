import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jobportals/core/constants/app_config.dart';
import 'package:jobportals/core/routes/app_route_methods.dart';
import 'package:jobportals/core/routes/app_route_names.dart';
import 'package:jobportals/core/theme/light.dart';
import 'package:jobportals/preloader.dart';
import 'package:jobportals/view/no_internet.dart';
import 'package:responsive_builder/responsive_builder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await preLoader();
  GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return GetMaterialApp(
              builder: (BuildContext context, widget) {
                ScreenUtil.init(
                  context,
                  designSize: getValueForScreenType(
                    context: context,
                    mobile: const Size(376, 667),
                    tablet: (!kIsWeb && context.isLandscape) ? const Size(1024, 768) : const Size(768, 1024),
                  ),
                );
                return OfflineBuilder(
                  connectivityBuilder: (
                      BuildContext context,
                      ConnectivityResult connectivity,
                      Widget child,
                      ) {
                    if (connectivity == ConnectivityResult.none) {
                      return const NoInternetScreen();
                    } else {
                      return child;
                    }
                  },
                  builder: (BuildContext context) {
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                      child: widget!,
                    );
                  },
                );
              },
              title: AppConfig.appName,
              debugShowCheckedModeBanner: false,
              theme: themeData,
              getPages: AppRouteMethods.pages,
              initialRoute: AppRouteNames.splash,
            );
          },
        );
      },
    );
  }
}
