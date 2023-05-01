import 'package:get/get.dart';
import 'package:jobportals/view/auth/auth_service.dart';

Future preLoader() async {
  await Get.putAsync(() => AuthService().init());
}
