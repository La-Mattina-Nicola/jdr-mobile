import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jdr/class/stat.dart';
import 'package:jdr/components/my_button.dart';
import 'package:jdr/components/my_textfield.dart';
import 'dart:io';
import '../components/my_menu.dart';

class AddCharacterPage extends StatefulWidget {
  const AddCharacterPage({super.key});

  @override
  State<AddCharacterPage> createState() => _AddCharacterPageState();
}

class _AddCharacterPageState extends State<AddCharacterPage> {
  final ImagePicker _picker = ImagePicker();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController gameController = TextEditingController();
  final TextEditingController otherController = TextEditingController();
  final TextEditingController statnameController = TextEditingController();
  final TextEditingController statvalueController = TextEditingController();
  final TextEditingController statmaxController = TextEditingController();

  final List<Map<String, dynamic>> statistiques = List.empty(growable: true);
  File? _imageFile;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
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
        title: Center(child: Text('Add statistique')),
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
              int max;
              if (statmaxController.text.isNotEmpty) {
                max = int.parse(statmaxController.text);
                stat = Stat(
                  name: statnameController.text,
                  value: value,
                  max: max,
                );
              } else {
                stat = Stat(
                  name: statnameController.text,
                  value: value,
                );
              }

              setState(() {
                statistiques.add(stat.toMap());
              });
              Navigator.pop(context);
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
          title: Text('Add a character'),
        ),
        drawer: MyDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(10),
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
                                stat['currentValue'].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            stat['maxValue'] != null
                                ? Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      stat['maxValue'].toString(),
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
              SizedBox(
                height: 10,
              ),
              MyButton(
                text: "SAVE",
                onTap: addCharactertoUser,
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        )
    );
  }

  void addCharactertoUser() {
    //recup user

    //recup l'objet character

  }
}
