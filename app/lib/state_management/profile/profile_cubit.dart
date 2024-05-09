import 'dart:async';
import 'dart:developer';

import 'package:app/common/api_response.dart';
import 'package:app/features/authentication/domain/user.dart';
import 'package:app/features/profile/data/profile_repo.dart';
import 'package:app/storage/local_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<User?> {
  final ProfileRepository _repo = ProfileRepository();

  ProfileCubit() : super(LocalStorage.userProfile);

  Future<void> clear() async {
    emit(null);
  }

  Future<({bool success, String result})> sendVerificationEmail() async {
    try {
      final ApiResponse res = await _repo.sendVerificationEmail();

      if (res.success == true) {
        return (success: true, result: "");
      } else {
        return (success: false, result: res.msg.toString());
      }
    } on TimeoutException catch (t) {
      log("Timeout Error: Can't connect to server");

      return (
        success: false,
        result: "(Timeout Error) Can't connect to server"
      );
    } catch (e) {
      log(e.toString());

      return (success: false, result: e.toString());
    }
  }

  Future<({bool success, String result})> verifyOtp(String otp) async {
    try {
      final ApiResponse res = await _repo.verifyOtp(otp);

      if (res.success == true) {
        User user = state!;

        user.isVerified = true;

        await LocalStorage.setAppUser(user);
        emit(user);

        return (success: true, result: "");
      } else {
        return (success: false, result: res.msg.toString());
      }
    } on TimeoutException catch (t) {
      log("Timeout Error: Can't connect to server");

      return (
        success: false,
        result: "(Timeout Error) Can't connect to server"
      );
    } catch (e) {
      log(e.toString());

      return (success: false, result: e.toString());
    }
  }
}
