import 'dart:developer';

import 'package:app/common/api_response.dart';
import 'package:app/features/authentication/domain/user.dart';
import 'package:app/features/profile/data/profile_repo.dart';
import 'package:app/storage/local_storage.dart';

class ProfileController {
  final ProfileRepository _repo = ProfileRepository();

  Future<({bool success, String result})> sendVerificationEmail() async {
    try {
      final ApiResponse res = await _repo.sendVerificationEmail();

      if (res.success == true) {
        return (success: true, result: "");
      } else {
        return (success: false, result: res.msg.toString());
      }
    } catch (e) {
      log(e.toString());

      return (success: false, result: e.toString());
    }
  }

  Future<({bool success, String result})> verifyOtp(String otp) async {
    try {
      final ApiResponse res = await _repo.verifyOtp(otp);

      if (res.success == true) {
        // TODO: update user profile
        User user = LocalStorage.userProfile!;

        user.isVerified = true;

        await LocalStorage.setAppUser(user);

        return (success: true, result: "");
      } else {
        return (success: false, result: res.msg.toString());
      }
    } catch (e) {
      log(e.toString());

      return (success: false, result: e.toString());
    }
  }
}
