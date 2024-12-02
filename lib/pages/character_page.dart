import 'package:flutter/material.dart';
import 'package:jdr/services/auth/auth_service.dart';
import 'package:jdr/components/my_menu.dart';

class CharacterPage extends StatelessWidget {
  const CharacterPage({super.key});

  void logout() {
    final _authService = AuthService();
    _authService.signOut();
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
              onTap: () {},
              child: Icon(Icons.edit),
            ),
          )
        ],
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1, 
                  child: Image.network(
                    'https://knight-jdr.fr/images/armures/Wizard_R.png', 
                    width: 200, 
                    height: 250, 
                  ),
                ),
                const SizedBox(width: 20), 
                Flexible(
                  flex: 2, 
                  child: ListView(
                    shrinkWrap: true,
                    children: const [
                      Text('Garibaldi', style: TextStyle(fontSize: 18)),
                      Text('Le fondateur', style: TextStyle(fontSize: 18)),
                      Text('Citoyen', style: TextStyle(fontSize: 18)),
                      Text('Création du Knight', style: TextStyle(fontSize: 18)),
                      Text('Blason : Dragon', style: TextStyle(fontSize: 18)),
                      Text('Section : Alpha', style: TextStyle(fontSize: 18)),
                    ],
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
                borderRadius: BorderRadius.circular(10)
              ),
              child: SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Statistiques", style: TextStyle(fontSize: 20)),
                            Text("Actuel", style: TextStyle(fontSize: 20)),
                            Text("Maximum", style: TextStyle(fontSize: 20))
                          ],
                        ),
                      ),
                      statContainer(context, "Point d'armure", "20", "40"),
                      statContainer(context, "Point d'énergie", "62", "80"),
                      statContainer(context, "Champ de force", "14", "14"),
                      statContainer(context, "Point de sante", "34", "34"),
                      statContainer(context, "Point de gloire", "13", "188"),
                      statContainer(context, "Point d'epérience", "3", "115"),
                      statContainer(context, "Héroïsme", "5"),
                      statContainer(context, "Contact", "6"),
                      statContainer(context, "Espoir", "45", "53"),
                      statContainer(context, "Défense", "4/5"),
                      statContainer(context, "Réaction", "3/4"),
                      statContainer(context, "Initiative", "3/3"),
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
                    statContainer(context, "TEST", "azdpok")
                  ],
                ),
              ),
            ),
          ],
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
                if(maximum != null)
                  Text("/"),
                if(maximum != null)
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


class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stats Screen"),
      ),
      body: Center(
        child: const Text("Bienvenue à l'écran des statistiques!"),
      ),
    );
  }
}

class CombatScreen extends StatelessWidget {
  const CombatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Combat Screen"),
      ),
      body: Center(
        child: const Text("Bienvenue à l'écran de combat!"),
      ),
    );
  }
}
