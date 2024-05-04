import 'dart:developer';

import 'package:app/common/api_response.dart';
import 'package:app/features/authentication/data/auth_repo.dart';
import 'package:app/features/authentication/domain/user.dart';
import 'package:app/storage/local_storage.dart';

class AuthController {
  String token = '';
  final AuthRepository _repo = AuthRepository();

  Future<String> registerUser(
      {required String email, required String password}) async {
    try {
      log("hererer");
      final ApiResponse res =
          await _repo.registerUser(email: email, password: password);

      log("complete");
      log(res.toString());

      return res.msg!;
    } catch (e) {
      log(e.toString());

      return e.toString();
    }
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    try {
      log("hererer");
      final ApiResponse res =
          await _repo.loginUser(email: email, password: password);

      log("complete");
      log(res.success.toString() +
          '\n' +
          res.msg.toString() +
          '\n' +
          res.data.toString());

      // token = res['token'];
      // await LocalStorage.setUserToken(res['token']);
      // await LocalStorage.setUserEmail(res['userData']['email']);

      log(res.data.toString());
      await LocalStorage.setAppUser(User.fromJson(res.data['userData']));

      return res.msg!;
    } catch (e) {
      log(e.toString());

      return e.toString();
    }
  }
}
