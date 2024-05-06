import 'package:app/features/authentication/domain/user.dart';
import 'package:hive_flutter/adapters.dart';

class LocalStorage {
  static Box<User>? userData;
  static Box? notesData;

  static String? get userId => userData!.get(StorageKeys.appUser)?.id;
  static String? get userToken => userData!.get(StorageKeys.appUser)?.token;
  static String? get userEmail => userData!.get(StorageKeys.appUser)?.email;
  static bool? get isUserVerified =>
      userData!.get(StorageKeys.appUser)!.isVerified;
  static User? get userProfile => userData!.get(StorageKeys.appUser);

  static Future<void> initialize() async {
    await Hive.initFlutter();

    Hive.registerAdapter(UserAdapter());

    userData = await Hive.openBox<User>(StorageKeys.userData);
    notesData = await Hive.openBox(StorageKeys.notesData);

    // print("intializing local storage");
    // print("==============================");
    // print(userData.toString());
    // print(userData!.get(StorageKeys.appUser));
  }

  static Future<void> setAppUser(User? user) async {
    await userData!.put(StorageKeys.appUser, user!);
  }

  /*
  static Future<void> setUserToken(String token) async {
    await userData!.put(StorageKeys.userToken, token);
  }

  static Future<void> setUserEmail(String email) async {
    await userData!.put(StorageKeys.email, email);
  }
   */

  static Future<void> clearData() async {
    await userData!.delete(StorageKeys.appUser);
    // await userData!.delete(StorageKeys.userToken);
    await notesData!.delete(StorageKeys.allNotes);
  }
}

class StorageKeys {
  // ***** BOXES NAME *****
  static const String userData = "userData";
  static const String notesData = "notesData";

  // ***** DATA KEYS *****
  static const String appUser = "appUser";
  static const String userToken = "userToken";
  static const String email = "email";
  static const String allNotes = "allNotes";
}
