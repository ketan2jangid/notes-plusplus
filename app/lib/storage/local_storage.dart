
import 'package:hive_flutter/adapters.dart';

class LocalStorage {
  static Box? userData;
  static Box? notesData;

  static String? get userToken => userData!.get(StorageKeys.userToken);
  static String? get userEmail => userData!.get(StorageKeys.email);

  static Future<void> initialize() async {
    await Hive.initFlutter();

    userData = await Hive.openBox(StorageKeys.userData);
    notesData = await Hive.openBox(StorageKeys.notesData);
  }

  static Future<void> setUserToken (String token) async {
    await userData!.put(StorageKeys.userToken, token);
  }

  static Future<void> setUserEmail (String email) async {
    await userData!.put(StorageKeys.email, email);
  }


  static Future<void> clearData () async {
    await userData!.delete(StorageKeys.userToken);
    await notesData!.delete(StorageKeys.allNotes);
  }
}

class StorageKeys {
  // ***** BOXES NAME *****
  static const String userData = "userData";
  static const String notesData = "notesData";

  // ***** DATA KEYS *****
  static const String userToken = "userToken";
  static const String email = "email";
  static const String allNotes = "allNotes";
}