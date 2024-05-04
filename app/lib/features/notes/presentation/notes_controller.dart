import 'dart:developer';

import 'package:app/common/notify_user.dart';
import 'package:app/features/notes/data/notes_repo.dart';

// class NotesController {
//   final NotesRepo _repo = NotesRepo();
//
//   Future<List> getAllNotes() async {
//     try {
//       final res = await _repo.fetchAllNotes();
//
//       return res['notes'];
//     } catch (e) {
//       log(e.toString());
//
//       // return e.toString();
//     }
//
//     return [];
//   }
//
//   Future<String> addNote({required String title, required String body}) async {
//     try {
//       final res = await _repo.addNote(title: title, body: body);
//
//       log(res['data'].toString());
//
//       return res['msg'];
//     } catch (e) {
//       log(e.toString());
//
//       return e.toString();
//     }
//   }
//
//   Future<String> updateNote(
//       {required String noteId,
//       required String title,
//       required String body}) async {
//     try {
//       final res =
//           await _repo.updateNote(noteId: noteId, title: title, body: body);
//
//       return res['msg'];
//     } catch (e) {
//       log(e.toString());
//
//       return e.toString();
//     }
//   }
//
//   Future<String> deleteNote({required String noteId}) async {
//     try {
//       final res = await _repo.deleteNote(noteId: noteId);
//
//       return res['msg'];
//     } catch (e) {
//       log(e.toString());
//
//       return e.toString();
//     }
//   }
// }
