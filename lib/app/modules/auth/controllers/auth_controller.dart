import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel/app/modules/auth/models/country_code.dart';
import 'package:novel/app/routes/app_routes.dart';
import 'package:novel/common/api/api_endpoint.dart';
import 'package:novel/common/services/storage_service.dart';
import 'package:novel/common/widgets/custom_snackbar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AuthController extends GetxController {
  final countryCodes = <CountryCode>[].obs;
  var selectedGender = 'Male'.obs;
  var selectedCountry = 'Malaysia (MY)'.obs;
  var countryCode = 'MY'.obs;
  var dialCode = '+60'.obs;
  var otpValues = ''.obs;
  var loadingVerifyOtp = false.obs;
  var loadingAuth = false.obs;
  var currentOtp = "".obs;
  var currentEmail = "".obs;

  final storageService = StorageService();

  //sign up controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    await getCountryCode();
  }

  Future<void> getCountryCode() async {
    try {
      final res = await ApiEndpoint().fetchCountryCode();
      if (res.isNotEmpty) {
        countryCodes.value = (res['data'] as List)
            .map((novelJson) => CountryCode.fromJson(novelJson))
            .toList();
      }
    } catch (e) {
      print('Error getting country code: $e');
    }
  }

  Future<void> signIn(String email) async {
    try {
      loadingAuth.value = true;
      final res = await ApiEndpoint().signIn(email);

      if (res.isNotEmpty) {
        print(res);
        print("OTP Code: ${res['otp']}");
        currentOtp.value = res['otp'];
        currentEmail.value = res['user']['email'];
        navigateToVerifyOtp();
      }
    } catch (e) {
      print('Error signing in: $e');
      customSnackbar(
        title: 'Error',
        message: 'Error signing in, Try again',
        icon: PhosphorIconsRegular.xCircle,
      );
    } finally {
      loadingAuth.value = false;
    }
  }

  validateInput() {
    if (emailController.text.isEmpty ||
        firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        phoneController.text.isEmpty) {
      customSnackbar(
        title: 'Error',
        message: 'Please fill all the details',
        icon: PhosphorIconsRegular.xCircle,
      );
      return false;
    }

    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(emailController.text)) {
      customSnackbar(
        title: 'Error',
        message: 'Please enter a valid email',
        icon: PhosphorIconsRegular.xCircle,
      );
      return false;
    }

    return true;
  }

  Future<void> signUp() async {
    try {
      if (!validateInput()) return;
      loadingAuth.value = true;
      final res = await ApiEndpoint().signUp({
        "email": emailController.text,
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "phoneNumber": dialCode.value + phoneController.text,
        "gender": selectedGender.value,
        "countryCode": countryCode.value,
      });
      if (res.isNotEmpty) {
        print(res);
        currentOtp.value = res['otp'];
        currentEmail.value = res['user']['email'];
        navigateToVerifyOtp();
      }
    } catch (e) {
      print('Error signing up: $e');
      customSnackbar(
        title: 'Error',
        message: 'Error signing up, Try again',
        icon: PhosphorIconsRegular.xCircle,
      );
    } finally {
      loadingAuth.value = false;
    }
  }

  void verifyOtp() async {
    try {
      loadingVerifyOtp.value = true;
      final res = await ApiEndpoint().verifyOtp(
        currentEmail.value.trim(),
        currentOtp.value.trim(),
      );
      if (res.isNotEmpty) {
        if (otpValues.value == currentOtp.value) {
          await storageService.saveLoggedIn(currentEmail.value);
          Get.offAllNamed(AppRoutes.home);
        } else {
          customSnackbar(
            title: 'Error',
            message: 'Invalid OTP Code',
            icon: PhosphorIconsRegular.xCircle,
          );
        }
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      customSnackbar(
        title: 'Error',
        message: 'Error verifying OTP, Try again',
        icon: PhosphorIconsRegular.xCircle,
      );
    } finally {
      loadingVerifyOtp.value = false;
    }
  }

  void navigateToSignUp() {
    Get.toNamed(AppRoutes.signup);
  }

  void navigateToSignIn() {
    Get.back();
  }

  void navigateToVerifyOtp() {
    Get.toNamed(AppRoutes.validateOtp);
    customSnackbar(
        title: 'Success',
        message: 'OTP Code: ${currentOtp.value}',
        icon: Icons.check_circle);
  }

  void setDialAndCountryCode(String code) {
    CountryCode? matchedCountry = countryCodes.firstWhere(
      (country) => country.code == code,
    );
    dialCode.value = matchedCountry.dialCode;
    countryCode.value = matchedCountry.code;
  }

  void isLoggedIn() async {
    await Future.delayed(const Duration(seconds: 2));
    final loggedEmail = await storageService.readLoggedIn();
    if (loggedEmail != null) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.signin);
    }
  }
}
