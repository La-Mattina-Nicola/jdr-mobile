import 'package:flutter/material.dart';
import 'package:jdr/class/character.dart';
import 'package:jdr/class/user.dart';
import 'package:jdr/components/my_menu.dart';
import 'package:jdr/pages/add_character_page.dart';
import 'package:jdr/services/class/user_service.dart';

class CharacterPage extends StatefulWidget {
  late final User user;
  late final Character character;
  CharacterPage({super.key, required this.user, required this.character});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  void _refreshPage() async { 
    UserService service = UserService();
    User refreshUser = await service.getCurrentUser();
    setState(() { 
      widget.character = refreshUser.characters!.firstWhere((character) => character == widget.character);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fiche personnage"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCharacterPage(
                      user: widget.user,
                      character: widget.character,
                    )
                  )
                );
                _refreshPage();
              },
              child: Icon(Icons.edit),
            ),
          )
        ],
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: widget.character.imageUrl!.isNotEmpty
                        ? Image.network(widget.character.imageUrl as String,
                            width: 200, height: 250)
                        : Icon(Icons.person,
                            size: 200), // Image ou icône par défaut
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 10),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondary
                          ),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Name', style: TextStyle(fontSize: 18)),
                                    Text(widget.character.name,
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Class', style: TextStyle(fontSize: 18)),
                                    Text(widget.character.characterClass,
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Game', style: TextStyle(fontSize: 18)),
                                    Text(widget.character.game,
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ],
                            ),
                            Text('Other', style: TextStyle(fontSize: 18)),
                            Text(
                                (widget.character.other != null &&
                                        widget.character.other!.isNotEmpty)
                                    ? widget.character.other!
                                    : 'No additional info',
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  height: 200,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Statistiques",
                                  style: TextStyle(fontSize: 20)),
                              Text("Actuel", style: TextStyle(fontSize: 20)),
                              Text("Maximum", style: TextStyle(fontSize: 20))
                            ],
                          ),
                        ),
                        ...widget.character.stats.map((stat) => statContainer(
                            context,
                            stat.name,
                            stat.value.toString(),
                            stat.max?.toString())),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Inventaire", style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      // Ajoutez votre logique d'affichage d'inventaire ici
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget statContainer(BuildContext context, String title, String minimum, [String? maximum]) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  minimum,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (maximum != null) Text("/"),
                if (maximum != null)
                  Text(
                    maximum,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
