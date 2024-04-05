import 'package:flutter/material.dart';
import 'package:noteapp/screens/error_screen.dart';
import 'package:noteapp/api/device_shared_data.dart';
import 'package:noteapp/screens/first_screen.dart';
import 'dart:developer' as dev;

void main() {
  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
          future: DeviceSharedData.getTokens(),
          builder: (context, snapshot) {
            dev.log(snapshot.data.toString());
            if (snapshot.hasData) {
              if (snapshot.data == "token") {
                return const MyHomePage(title: 'Flutter Demo Home Page');
              } else if (snapshot.data == "wrong token") {
                return const FirstScreen();
              } else {
                return const ErrorScreen(
                    error: 'Put the error from API or other here');
              }
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text("Hello World"),
      ),
    );
  }
}
