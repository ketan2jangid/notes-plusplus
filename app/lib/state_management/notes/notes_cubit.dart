import 'dart:async';
import 'dart:developer';

import 'package:app/common/api_response.dart';
import 'package:app/features/notes/data/notes_repo.dart';
import 'package:app/features/notes/domain/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesCubit extends Cubit<List<NoteModel>> {
  final NotesRepo _repo = NotesRepo();

  NotesCubit() : super([]);

  Future<void> clear() async {
    emit([]);
  }

  Future<({bool success, String result})> getAllNotes() async {
    try {
      final ApiResponse res = await _repo.fetchAllNotes();

      if (res.success == true) {
        List<NoteModel> notes = <NoteModel>[];
        var data = res.data['notes'];

        data.forEach((note) => notes.add(NoteModel.fromJson(note)));

        emit(notes);

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

  Future<({bool success, String result})> addNote(
      {required String title, required String body}) async {
    try {
      final ApiResponse res = await _repo.addNote(title: title, body: body);

      if (res.success == true) {
        emit([...state, NoteModel.fromJson(res.data['newNote'])]);

        return (success: true, result: "New note added");
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

  Future<({bool success, String result})> updateNote(
      {required String noteId,
      required String title,
      required String body}) async {
    try {
      final ApiResponse res =
          await _repo.updateNote(noteId: noteId, title: title, body: body);

      if (res.success == true) {
        List<NoteModel> notesUpdated = List.from(state);

        int index = notesUpdated.indexWhere((element) => element.id == noteId);

        // log(index.toString() +
        //     "   " +
        //     notesUpdated[index].title! +
        //     " " +
        //     notesUpdated[index].body!);

        notesUpdated[index].title = title;
        notesUpdated[index].body = body;

        // log(index.toString() +
        //     "   " +
        //     notesUpdated[index].title! +
        //     " " +
        //     notesUpdated[index].body!);

        emit(notesUpdated);

        return (success: true, result: "Note updated");
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

  Future<({bool success, String result})> deleteNote(
      {required String noteId}) async {
    try {
      final res = await _repo.deleteNote(noteId: noteId);

      if (res.success == true) {
        List<NoteModel> notes = state;

        notes.removeWhere((element) => element.id == noteId);

        emit(notes);

        return (success: true, result: "Note deleted");
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
