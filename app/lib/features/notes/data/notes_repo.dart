import 'dart:convert';
import 'dart:developer';

import 'package:app/common/api_response.dart';
import 'package:app/common/endpoints.dart';
import 'package:app/features/authentication/presentation/auth_controller.dart';
import 'package:app/storage/local_storage.dart';
import 'package:http/http.dart' as http;

class NotesRepo {
  Future<ApiResponse> fetchAllNotes() async {
    try {
      final res = await http.get(
          Uri.parse("${Endpoints.notes}${Endpoints.getAll}"),
          headers: {'authentication': LocalStorage.userToken!});

      log("########### NOTES #########");
      log(res.toString());

      if (res.statusCode == 200) {
        return ApiResponse.fromJson(jsonDecode(res.body));
      } else {
        return ApiResponse.fromJson(jsonDecode(res.body));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> addNote(
      {required String title, required String body}) async {
    try {
      final res = await http.post(
        Uri.parse("${Endpoints.notes}"),
        headers: {
          'authentication': LocalStorage.userToken!,
          "Content-Type": "application/json"
        },
        body: jsonEncode({"title": title, "body": body}),
      );

      log("########### ADD #########");
      log(res.toString());

      if (res.statusCode == 201) {
        return ApiResponse.fromJson(jsonDecode(res.body));
      } else {
        return ApiResponse.fromJson(jsonDecode(res.body));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> updateNote(
      {required String noteId,
      required String title,
      required String body}) async {
    try {
      final res = await http.put(Uri.parse("${Endpoints.notes}${noteId}"),
          headers: {
            'authentication': LocalStorage.userToken!,
            "Content-Type": "application/json"
          },
          body: jsonEncode({"title": title, "body": body}));

      log("########### UPDATE #########");
      log(res.toString());

      if (res.statusCode == 201) {
        return ApiResponse.fromJson(jsonDecode(res.body));
      } else {
        return ApiResponse.fromJson(jsonDecode(res.body));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> deleteNote({required String noteId}) async {
    try {
      final res = await http.delete(Uri.parse("${Endpoints.notes}${noteId}"),
          headers: {'authentication': LocalStorage.userToken!});

      log("########### DELETE #########");
      log(res.toString());

      if (res.statusCode == 200) {
        return ApiResponse.fromJson(jsonDecode(res.body));
      } else {
        return ApiResponse.fromJson(jsonDecode(res.body));
      }
    } catch (e) {
      rethrow;
    }
  }
}
