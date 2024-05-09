import 'dart:convert';
import 'dart:developer';

import 'package:app/common/api_response.dart';
import 'package:app/common/endpoints.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<ApiResponse> registerUser(
      {required String email, required String password}) async {
    try {
      Map<String, dynamic> data = {"email": email, "password": password};

      final res = await http
          .post(
            Uri.parse("${Endpoints.auth}${Endpoints.register}"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(data),
            encoding: utf8,
          )
          .timeout(const Duration(seconds: 7));

      log(res.toString());

      return ApiResponse.fromJson(jsonDecode(res.body));

      // if (res.statusCode == 201) {
      //   return jsonDecode(res.body);
      // } else {
      //   return jsonDecode(res.body);
      // }
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> loginUser(
      {required String email, required String password}) async {
    try {
      Map<String, dynamic> data = {"email": email, "password": password};

      final res = await http
          .post(
            Uri.parse("${Endpoints.auth}${Endpoints.login}"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(data),
            encoding: utf8,
          )
          .timeout(const Duration(seconds: 7));

      log(res.toString());

      log("### JSON ###");
      log(jsonDecode(res.body).toString());

      return ApiResponse.fromJson(jsonDecode(res.body));

      // if (res.statusCode == 201) {
      //   return jsonDecode(res.body);
      // } else {
      //   return jsonDecode(res.body);
      // }
    } catch (e) {
      rethrow;
    }
  }
}
