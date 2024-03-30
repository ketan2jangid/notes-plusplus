import 'dart:convert';
import 'dart:developer';

import 'package:app/common/endpoints.dart';
import 'package:app/features/authentication/presentation/auth_controller.dart';
import 'package:app/storage/local_storage.dart';
import 'package:http/http.dart' as http;

class NotesRepo {
  Future<Map<String, dynamic>> fetchAllNotes() async {
    try {
      final res = await http.get(
          Uri.parse("${Endpoints.notes}${Endpoints.getAll}"),
          headers: {'authentication': LocalStorage.userToken!});

      log("########### NOTES #########");
      log(res.toString());

      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        return jsonDecode(res.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> addNote({required String title, required String body}) async {
    try {
      final res = await http.post(
          Uri.parse("${Endpoints.notes}"),
          headers: {'authentication': LocalStorage.userToken!, "Content-Type": "application/json"},
        body: jsonEncode({
          "title": title,
          "body": body
        })
      );

      log("########### ADD #########");
      log(res.toString());

      if (res.statusCode == 201) {
        return jsonDecode(res.body);
      } else {
        return jsonDecode(res.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateNote({required String noteId, required String title, required String body}) async {
    try {
      final res = await http.put(
          Uri.parse("${Endpoints.notes}${noteId}"),
          headers: {'authentication': LocalStorage.userToken!, "Content-Type": "application/json"},
          body: jsonEncode({
            "title": title,
            "body": body
          })
      );

      log("########### UPDATE #########");
      log(res.toString());

      if (res.statusCode == 201) {
        return jsonDecode(res.body);
      } else {
        return jsonDecode(res.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> deleteNote({required String noteId}) async {
    try {
      final res = await http.delete(
          Uri.parse("${Endpoints.notes}${noteId}"),
          headers: {'authentication': LocalStorage.userToken!}
      );

      log("########### DELETE #########");
      log(res.toString());

      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        return jsonDecode(res.body);
      }
    } catch (e) {
      rethrow;
    }
  }
}
