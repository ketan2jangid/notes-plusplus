import 'package:app/common/app_colors.dart';
import 'package:app/features/authentication/presentation/login_screen.dart';
import 'package:app/features/notes/presentation/home_screen.dart';
import 'package:app/storage/local_storage.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes++',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: appBackgroundColor,
      ),
      home: LocalStorage.userToken != null ? HomeScreen() : LoginScreen(),
    );
  }
}
