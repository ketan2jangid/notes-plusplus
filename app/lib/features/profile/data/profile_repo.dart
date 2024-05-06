import 'dart:convert';
import 'dart:developer';

import 'package:app/common/api_response.dart';
import 'package:app/common/endpoints.dart';
import 'package:app/storage/local_storage.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {
  Future<ApiResponse> sendVerificationEmail() async {
    try {
      final http.Response res = await http.get(
        Uri.parse("${Endpoints.auth}${Endpoints.sendVerificationEmail}"),
        headers: {'authentication': LocalStorage.userToken!},
      );

      log(res.toString());

      return ApiResponse.fromJson(jsonDecode(res.body));
    } catch (err) {
      rethrow;
    }
  }

  Future<ApiResponse> verifyOtp(String otp) async {
    try {
      final http.Response res = await http.post(
        Uri.parse("${Endpoints.auth}${Endpoints.verifyOtp}"),
        headers: {
          'authentication': LocalStorage.userToken!,
          "Content-Type": "application/json"
        },
        body: jsonEncode({"otp": otp}),
      );

      log(res.toString());

      return ApiResponse.fromJson(jsonDecode(res.body));
    } catch (err) {
      rethrow;
    }
  }
}
