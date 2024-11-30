import 'package:flutter/material.dart';
import 'package:jdr/auth/auth_service.dart';

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
          IconButton(onPressed: logout, icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1, // Image takes 1/3 of the width
                  child: Image.network(
                    'https://knight-jdr.fr/images/armures/Wizard_R.png', // Replace with your image URL
                    width: 200, // Adjust width if needed
                    height: 150, // Adjust height if needed
                  ),
                ),
                const SizedBox(width: 20), // Add some space between the image and text
                Flexible(
                  flex: 2, // Text takes 2/3 of the width
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
            const SizedBox(height: 20), // Add some space between the row and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to stats screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StatsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom( backgroundColor: Colors.redAccent,),
                  child: const Text(
                    "Stats",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 20), // Add some space between the buttons
                ElevatedButton(
                  onPressed: () {
                    // Navigate to combat screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CombatScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom( backgroundColor: Colors.redAccent,),
                  child: const Text(
                    "Combat",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Add some space between the buttons and stats
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  statContainer("PA", "20/40", 73.0),
                  Padding(padding: const EdgeInsets.all(2)),
                  statContainer("PE", "62/80", 73.0),
                  Padding(padding: const EdgeInsets.all(2)),
                  statContainer("CDF", "14/14", 73.0),
                  Padding(padding: const EdgeInsets.all(2)),
                  statContainer("PS", "34/34", 73.0),
                ],
              ),
            ),
            const SizedBox(height: 10), // Add some space between the buttons and stats
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  statContainer("Point de gloire", "13/188", 150.0),
                  Padding(padding: const EdgeInsets.all(2)),
                  statContainer("Point d'expérience", "3/115", 150.0),
                ],
              ),
            ),
            const SizedBox(height: 10), // Add some space between the buttons and stats
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  statContainer("Héroïsme", "5", 100.0),
                  Padding(padding: const EdgeInsets.all(2)),
                  statContainer("Contact", "6", 100.0),
                  Padding(padding: const EdgeInsets.all(2)),
                  statContainer("Espoir", "45/53", 100.0),
                ],
              ),
            ),
            const SizedBox(height: 10), // Add some space between the buttons and stats
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  statContainer("Défense", "4/5", 100.0),
                  Padding(padding: const EdgeInsets.all(2)),
                  statContainer("Réaction", "3/4", 100.0),
                  Padding(padding: const EdgeInsets.all(2)),
                  statContainer("Initiative", "3/3", 100.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget statContainer(String title, String value, double? width) {
  return Container(
    width: width,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.redAccent,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
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
