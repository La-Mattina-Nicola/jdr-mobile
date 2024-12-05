import 'package:flutter/material.dart';
import 'package:jdr/class/character.dart';
import 'package:jdr/class/user.dart';
import 'package:jdr/components/my_item_menu.dart';
import 'package:jdr/components/my_menu.dart';
import 'package:jdr/pages/add_character_page.dart';
import 'package:jdr/pages/character_page.dart';
import 'package:jdr/services/class/user_service.dart';

class MyHomePage extends StatefulWidget {
  late final User user;
  MyHomePage({super.key, required this.user});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final List<Character> characters;
  @override 
  void initState() { 
    super.initState(); 
  }
  void _refreshPage() async { 
    UserService service = UserService();
    User u = await service.getCurrentUser();
    setState(() { 
      widget.user = u;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text('HOME'),
      ),
      drawer: MyDrawer(),
      body: ListView(
        children: [
          buildUserCharacter(widget.user),
          Padding(padding: EdgeInsets.all(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "My tables",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.add),
                ),
              ),
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

  Widget buildUserCharacter(User user) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "My characters",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddCharacterPage(user: user),
                    ),
                  );
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
        if (user.characters!.isEmpty)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCharacterPage(user: user),
                ),
              );
            },
            child: Center(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                child: Text("Add a character"),
              ),
            ),
          )
        else
          Column(
            children: [
              for (var char in user.characters!)
                MyItemMenu(
                  leading: char.imageUrl != null && char.imageUrl!.isNotEmpty
                      ? Image.network(char.imageUrl as String)
                      : Icon(Icons.person, size: 50), // Utilisez une icône par défaut si l'image est nulle
                  icon: Icons.person,
                  text: char.name,
                  color: Colors.white,
                  subtitle: Text(char.game),
                  trailing: Icon(Icons.more_horiz),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterPage(user: user, character: char),
                      ),
                    );
                    _refreshPage();
                  },
                ),
            ],
          ),
      ],
    );
  }


}
