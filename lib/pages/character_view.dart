import 'package:flutter/material.dart';

class CharacterView extends StatelessWidget {
  const CharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fiche personnage"),
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
                      Text('John Doe', style: TextStyle(fontSize: 18)),
                      Text('JD', style: TextStyle(fontSize: 18)),
                      Text('Leader', style: TextStyle(fontSize: 18)),
                      Text('Record Holder', style: TextStyle(fontSize: 18)),
                      Text('Eagle', style: TextStyle(fontSize: 18)),
                      Text('Alpha', style: TextStyle(fontSize: 18)),
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
                  statContainer("PA", "150", 73.0),
                  Padding(padding: const EdgeInsets.all(2)),
                  statContainer("PE", "80", 73.0),
                  Padding(padding: const EdgeInsets.all(2)),
                  statContainer("CDF", "60", 73.0),
                  Padding(padding: const EdgeInsets.all(2)),
                  statContainer("PS", "100", 73.0),
                ],
              ),
            ),
            const SizedBox(height: 10), // Add some space between the buttons and stats
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  statContainer("Point de gloire", "150", 150.0),
                  Padding(padding: const EdgeInsets.all(2)),
                  statContainer("Point d'expérience", "80", 150.0),
                ],
              ),
            ),
            const SizedBox(height: 10), // Add some space between the buttons and stats
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  statContainer("Héroïsme", "150", 100.0),
                  Padding(padding: const EdgeInsets.all(2)),
                  statContainer("Contact", "80", 100.0),
                  Padding(padding: const EdgeInsets.all(2)),
                  statContainer("Espoir", "80", 100.0),
                ],
              ),
            ),
            const SizedBox(height: 10), // Add some space between the buttons and stats
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  statContainer("Défense", "150", 100.0),
                  Padding(padding: const EdgeInsets.all(2)),
                  statContainer("Réaction", "80", 100.0),
                  Padding(padding: const EdgeInsets.all(2)),
                  statContainer("Initiative", "80", 100.0),
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
