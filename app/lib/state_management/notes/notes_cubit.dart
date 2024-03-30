import 'dart:developer';

import 'package:app/features/notes/data/notes_repo.dart';
import 'package:app/features/notes/domain/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesCubit extends Cubit<List<NoteModel>> {
  final NotesRepo _repo = NotesRepo();

  NotesCubit() : super([]);

  Future<({bool success, String result})> getAllNotes() async {
    try {
      final res = await _repo.fetchAllNotes();

      if (res['msg'] == "Notes retrieved successfully") {
        List<NoteModel> notes = <NoteModel>[];
        var data = res['notes'];

        data.forEach((note) => notes.add(NoteModel.fromJson(note)));

        emit(notes);

        return (success: true, result: "");
      } else {
        return (success: false, result: res['msg'].toString());
      }
    } catch (e) {
      log(e.toString());

      return (success: false, result: e.toString());
    }
  }

  Future<({bool success, String result})> addNote(
      {required String title, required String body}) async {
    try {
      final res = await _repo.addNote(title: title, body: body);

      if (res['msg'] == "New note added successfully") {
        emit([...state, NoteModel.fromJson(res['data'])]);

        return (success: false, result: "");
      } else {
        return (success: false, result: res['msg'].toString());
      }
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
      final res =
          await _repo.updateNote(noteId: noteId, title: title, body: body);

      if (res['msg'] == "Note updated successfully") {
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

        return (success: true, result: "");
      } else {
        return (success: false, result: res['msg'].toString());
      }
    } catch (e) {
      log(e.toString());

      return (success: false, result: e.toString());
    }
  }

  Future<({bool success, String result})> deleteNote(
      {required String noteId}) async {
    try {
      final res = await _repo.deleteNote(noteId: noteId);

      if (res['msg'] == "note deleted successfully") {
        List<NoteModel> notes = state;

        notes.removeWhere((element) => element.id == noteId);

        emit(notes);

        return (success: true, result: "");
      } else {
        return (success: false, result: res['msg'].toString());
      }
    } catch (e) {
      log(e.toString());

      return (success: false, result: e.toString());
    }
  }
}
