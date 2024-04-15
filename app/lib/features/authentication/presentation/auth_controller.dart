import 'dart:developer';

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
      final res = await _repo.registerUser(email: email, password: password);

      log("complete");
      log(res.toString());

      return res['msg'];
    } catch (e) {
      log(e.toString());

      return e.toString();
    }
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    try {
      log("hererer");
      final res = await _repo.loginUser(email: email, password: password);

      log("complete");
      log(res.toString());

      await LocalStorage.setAppUser(User.fromJson(res['userData']));

      return res['msg'];
    } catch (e) {
      log(e.toString());

      return e.toString();
    }
  }
}
