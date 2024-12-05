import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jdr/class/stat.dart';
import 'package:jdr/class/character.dart';
import 'package:jdr/class/user.dart';
import 'package:jdr/components/my_button.dart';
import 'package:jdr/components/my_textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jdr/services/class/character_service.dart';
import 'dart:io';
import '../components/my_menu.dart';

class AddCharacterPage extends StatefulWidget {
  final User user;
  final Character? character;
  const AddCharacterPage({required this.user, super.key, this.character});

  @override
  State<AddCharacterPage> createState() => _AddCharacterPageState();
}

class _AddCharacterPageState extends State<AddCharacterPage> {
  final CharacterService characterService = CharacterService();
  final ImagePicker _picker = ImagePicker();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController gameController = TextEditingController();
  final TextEditingController otherController = TextEditingController();
  final TextEditingController statnameController = TextEditingController();
  final TextEditingController statvalueController = TextEditingController();
  final TextEditingController statmaxController = TextEditingController();
  final List<Map<String, dynamic>> statistiques = [];
  File? _imageFile;
  
  get user => widget.user;

  @override
  void dispose() {
    nameController.dispose();
    classController.dispose();
    gameController.dispose();
    otherController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if(widget.character != null) {
      nameController.text = widget.character!.name;
      classController.text = widget.character!.characterClass;
      gameController.text = widget.character!.game;
      for(var stat in widget.character!.stats) {
        statistiques.add({
          'name': stat.name,
          'value': stat.value,
          'max': stat.max,
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  Future<String?> _uploadImage(File imageFile) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('character_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() {});
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }
  


  void addStat() {
    // reset controller
    statnameController.text = '';
    statvalueController.text = '';
    statmaxController.text = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(child: Text('Add statistic')),
        content: SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyTextField(
                  hintText: "Name",
                  obscureText: false,
                  controller: statnameController),
              SizedBox(
                height: 10,
              ),
              MyTextField(
                hintText: "Value",
                obscureText: false,
                controller: statvalueController,
                input: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              MyTextField(
                hintText: "Max",
                obscureText: false,
                controller: statmaxController,
                input: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          MyButton(
            text: "Submit",
            onTap: () {
              Stat stat;
              int value = int.parse(statvalueController.text);
              int? max = statmaxController.text.isNotEmpty ? int.parse(statmaxController.text) : null;
              stat = Stat(
                id: '',
                name: statnameController.text,
                value: value,
                max: max,
              );
              setState(() {
                statistiques.add(stat.toMap());
              });
              Navigator.pop(context);
              if(widget.character != null) {
                //appel service stat pour ajouter la stat
                characterService.addStatToCharacter(widget.user.id!, widget.character!.id!, stat);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.character != null ? 'Edit a character' : 'Add a character'
        ),
      ),
      drawer: MyDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:10, right:10),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.secondary),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 250,
                        width: 150,
                        child: Center(
                          child: _imageFile == null
                              ? Text('No image selected')
                              : Image.file(_imageFile!),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyTextField(
                              hintText: "Name",
                              obscureText: false,
                              controller: nameController),
                          SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              hintText: "Class",
                              obscureText: false,
                              controller: classController),
                          SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              hintText: "Game",
                              obscureText: false,
                              controller: gameController),
                          SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              hintText: "Other",
                              obscureText: false,
                              controller: otherController),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Expanded(
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Statistics',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          GestureDetector(
                            onTap: addStat,
                            child: Icon(Icons.add),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Table(
                        border: TableBorder.all(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.secondary),
                        children: [
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Name',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Value',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Max',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                          for (var stat in statistiques)
                            TableRow(children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  stat['name'],
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  stat['value'].toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              stat['max'] != null
                                  ? Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        stat['max'].toString(),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ]),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                MyButton(
                  text: widget.character != null ? 'Edit' : 'Save',
                  onTap: addCharactertoUser,
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ]
      )
    );
  }

  void addCharactertoUser() async {
    // Récupère l'utilisateur actuel
    User currentUser = widget.user;
    // Vérifie si l'utilisateur a un identifiant valide
    if (currentUser.id == null || currentUser.id!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User ID is invalid!')),
      );
      return;
    }
    
    // Télécharge l'image et obtient l'URL
    String? imageUrl;
    if (_imageFile != null) {
      imageUrl = await _uploadImage(_imageFile!);
    }

    Character character = Character(
      name: nameController.text,
      characterClass: classController.text,
      game: gameController.text,
      other: otherController.text,
      imageUrl: imageUrl,
    );

    // Crée l'objet Character
    if(widget.character == null) {
      // création de la collection
      character.createCharacter(currentUser.id!);
    }
    widget.user.characters!.firstWhere((character) => character == widget.character).updateCharacter(currentUser.id!);
    // Affiche un message de confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(widget.character != null ? 'Character edited successfully!' : 'Character saved successfully!'), backgroundColor: Colors.green),
    );

    // Retourne à l'écran précédent
    Navigator.pop(context);
  }
}
