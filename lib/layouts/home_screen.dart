import 'package:flutter/material.dart';
import 'package:noteapp/layouts/mutation_screen.dart';
import 'package:noteapp/models/note.dart';
import 'package:noteapp/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart ';
import 'dart:developer' show log;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  

  List<Widget> pages = [
    HomePage(),
    HomePage(),
  ];

  void changePage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? userName = FirebaseAuth.instance.currentUser?.displayName;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          title: Text("Welcome ${userName ?? ""}"),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.person))
          ],
          titleTextStyle: const TextStyle(
            fontSize: 25.0,
          ),
          bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 100),
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SearchAnchor(
                    builder:
                        (BuildContext context, SearchController controller) {
                      return SearchBar(
                        onTap: () => controller.openView(),
                        hintText: "Search notes",
                        leading: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {},
                        ),
                      );
                    },
                    suggestionsBuilder: (context, controller) {
                      return List<ListTile>.generate(5, (int index) {
                        final String item = 'item $index';
                        return ListTile(
                          title: Text(item),
                          onTap: () {
                            setState(() {
                              controller.closeView(item);
                            });
                          },
                        );
                      });
                    },
                  )))),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.notes),
            label: "Notes",
          ),
          NavigationDestination(
            icon: Icon(Icons.cloud),
            label: "Cloud",
          ),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            pageIndex = index;
          });
        },
        selectedIndex: pageIndex,
        animationDuration: Durations.short2,
        backgroundColor: const Color.fromARGB(255, 41, 41, 48),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: pages[pageIndex],
      ),
    );
  }
}
