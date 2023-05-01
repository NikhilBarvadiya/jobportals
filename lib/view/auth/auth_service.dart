// ignore_for_file: invalid_use_of_protected_member
import 'package:get/get.dart';

class AuthService extends GetxService {
  Future<AuthService> init() async => this;
  RxString verificationToken = "".obs;
  RxBool isUserLoggedIn = false.obs;
  dynamic userData = {}.obs;

  Future signIn(body) async {}

  Future registration(body, otp) async {}
}
