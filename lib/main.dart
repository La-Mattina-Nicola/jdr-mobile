import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade300,
          primary: Colors.grey.shade500,
          secondary: Colors.grey.shade200,
          tertiary: Colors.deepOrangeAccent,
          inversePrimary: Colors.grey.shade900,
        )
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          surface: Colors.grey.shade900,
          primary: Colors.grey.shade700,
          secondary: Colors.grey.shade800,
          tertiary: Colors.deepOrangeAccent,
          inversePrimary: Colors.grey.shade900
        )
      ),
      home: const MyHomePage(title: 'JDR viewer'),
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
      body: ListView(
        children: const [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            ],
          ),
        ]
      ),
    );
  }
}
