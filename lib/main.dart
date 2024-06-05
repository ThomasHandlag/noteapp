import 'package:firebase_auth/firebase_auth.dart%20';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:noteapp/api/device_shared_data.dart';
import 'package:noteapp/database/local_db.dart';
import 'package:noteapp/layouts/first_screen.dart';
import 'package:noteapp/layouts/home_screen.dart';
import 'package:noteapp/layouts/sign_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:noteapp/firebase_options.dart';
import 'dart:developer' show log;

import 'package:noteapp/themes/theme_color.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  Gemini.init(apiKey:const String.fromEnvironment('API_KEY'), enableDebugging: true);
  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});
  Future<Database> createDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'local.db'),
      version: 2,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY autoincrement, title TEXT, content TEXT, imagePath TEXT, audioPath TEXT, createdAt TEXT, modifiedAt TEXT)',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    createDB().then((value) {
      NoteAppLocalDatabase.instance = NoteAppLocalDatabase.init(value);
    });
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      themeMode: ThemeMode.dark,
      home: FutureBuilder(
          future: DeviceSharedData.isUsedBefore(),
          builder: (context, snapshot) {
            return FutureBuilder(
                future: Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
                builder: (_, snapshot2) {
                  if (snapshot.hasData && snapshot2.connectionState == ConnectionState.done) {
                    if (snapshot.data == true) {
                      if (FirebaseAuth.instance.currentUser == null) {
                        return const SignScreen();
                      }
                      else {
                        return const HomeScreen();
                      }
                    } else {
                      return const FirstScreen();
                    }
                  }
                  return const CircularProgressIndicator();
                });
          }),
    );
  }
}