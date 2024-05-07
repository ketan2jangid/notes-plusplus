import 'dart:async';
import 'dart:developer';

import 'package:app/common/api_response.dart';
import 'package:app/features/authentication/data/auth_repo.dart';
import 'package:app/features/authentication/domain/user.dart';
import 'package:app/storage/local_storage.dart';

class AuthController {
  String token = '';
  final AuthRepository _repo = AuthRepository();

  Future<({bool success, String result})> registerUser(
      {required String email, required String password}) async {
    try {
      final ApiResponse res =
          await _repo.registerUser(email: email, password: password);

      log(res.toString());

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

  Future<({bool success, String result})> loginUser(
      {required String email, required String password}) async {
    try {
      final ApiResponse res =
          await _repo.loginUser(email: email, password: password);

      log(res.success.toString() +
          '\n' +
          res.msg.toString() +
          '\n' +
          res.data.toString());

      // token = res['token'];
      // await LocalStorage.setUserToken(res['token']);
      // await LocalStorage.setUserEmail(res['userData']['email']);

      if (res.success == true) {
        log(res.data.toString());
        await LocalStorage.setAppUser(User.fromJson(res.data['userData']));

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
