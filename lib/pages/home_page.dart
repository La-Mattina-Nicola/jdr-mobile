
import 'package:flutter/material.dart';
import 'package:jdr/components/my_item_menu.dart';
import 'package:jdr/pages/character_page.dart';

import '../components/my_menu.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('HOME'),
      ), 
      drawer: MyDrawer(),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text("My characters", style: TextStyle(fontSize: 20),),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.add),
                ),
              )
            ],
          ),
          MyItemMenu(
            text: "Wizard : Garibaldi",
            icon: Icons.person,
            color: Colors.white,
            subtitle: Text("Knight"),
            trailing: Icon(Icons.more_horiz),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CharacterPage()));
            },
          ),
          Padding(padding: EdgeInsets.all(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text("My tables", style: TextStyle(fontSize: 20),),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.add),
                ),
              )
            ],
          ),
          MyItemMenu(
            text: "Knight",
            icon: Icons.table_bar, 
            color: Colors.white,
            trailing: Icon(Icons.more_horiz),  
          ),
        ],
      ),
    );
  }
}

