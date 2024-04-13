import 'package:flutter/material.dart';
import 'package:noteapp/components/filter_dialog.dart';

class CAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  const CAppBar({super.key, required this.title});

  @override
  State<CAppBar> createState() => _CAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}

class _CAppBarState extends State<CAppBar> {
  void onSearch(String value) {}

  String searchValue = "";

  @override
  Widget build(BuildContext context) {
    return Container(
        height: kToolbarHeight * 2,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            color: Theme.of(context).colorScheme.background),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(215, 46, 40, 59),
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide.none),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Colors.white30,
                    )),
                style: const TextStyle(
                  color: Colors.white,
                ),
                onChanged: (value) {
                  setState(() {
                    searchValue = value;
                  });
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
              child: IconButton(
                onPressed: () {
                  onSearch("");
                },
                icon: const Icon(Icons.search),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(const CircleBorder()),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(const CircleBorder()),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
              child: IconButton(
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => FilterDialog(),
                ),
                icon: const Icon(Icons.filter_list),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(const CircleBorder()),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                ),
              ),
            )
          ],
        ));
  }
}
