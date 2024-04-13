import 'package:flutter/material.dart';
import 'package:noteapp/layouts/mutation_screen.dart';
import 'package:noteapp/models/note.dart';
import 'package:noteapp/pages/home_page.dart';
import 'package:noteapp/pages/settings_pages.dart';
import 'package:noteapp/components/capp_bar.dart';
import 'dart:developer' as dev;
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int pageIndex = 0;

  void setMutationData(Note? note) {
    setState(() {
      pageIndex = 3;
      pages[pageIndex] = MutationScreen(note: note);
    });
  }
  
  List<Widget> pages = [
    HomePage(onPress: (Note? note) {
    }), 
    HomePage(onPress: (Note? note) {
     
    }),
    const SettingsPage(),
    const MutationScreen(note: null),
  ];

  void changePage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: pageIndex == 0 ? CAppBar(title: 'Notes App') : null,
      bottomNavigationBar: NavigationBar(
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.notes),
            label: "Notes",
          ),
          const NavigationDestination(
            icon: Icon(Icons.cloud),
            label: "Cloud",
          ),
          const NavigationDestination(
              icon: Icon(Icons.settings), label: "Settings"),
          Transform.translate(
              offset: const Offset(0, -40),
              child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow( 
                          color: Color.fromARGB(255, 151, 145, 169),
                          offset: Offset(0, 0),
                          blurRadius: 8.0,
                        )
                      ],
                      shape: BoxShape.circle,
                    ),
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          pageIndex = 3;
                        });
                      },
                      backgroundColor: const Color.fromARGB(255, 102, 39, 203),
                      tooltip: "Add note",
                      shape: const CircleBorder(),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  )))
        ],
        onDestinationSelected: (int index) {
          setState(() {
            pageIndex = index;
            if (pageIndex ==0) {
              setState(() {
                pages[index] = HomePage(onPress: (Note? note) {
                  setMutationData(note);
                });
              });
            }
            dev.log(index.toString());
          });
        },
        selectedIndex: pageIndex,
        animationDuration: Durations.short2,
        backgroundColor: const Color.fromARGB(255, 41, 41, 48),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.5, 1],
            colors: [
              Color.fromARGB(255, 19, 19, 32),
              Color.fromARGB(255, 50, 81, 255)
            ],
          ),
          image: DecorationImage(
              image: AssetImage('assets/images/sl_bg.png'), fit: BoxFit.fill),
        ),
        child: pages[pageIndex],
      ),
    );
  }
}
