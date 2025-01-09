// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:practical_exam/models/entity.dart';
import 'package:practical_exam/widgets/pop_up_dialog.dart';
import 'package:practical_exam/widgets/text_box.dart';

class AddEntity extends StatefulWidget {
  const AddEntity({super.key});

  @override
  State<StatefulWidget> createState() => _AddEntityState();
}

class _AddEntityState extends State<AddEntity> {
  late TextEditingController name;
  late TextEditingController breed;
  late TextEditingController age;
  late TextEditingController weight;
  late TextEditingController owner;
  late TextEditingController location;
  late TextEditingController description;

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    breed = TextEditingController();
    age = TextEditingController();
    weight = TextEditingController();
    owner = TextEditingController();
    location = TextEditingController();
    description = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add pet"),
        ),
        body: ListView(
          children: [
            TextBox(name, "name"),
            TextBox(breed, "breed"),
            TextBox(age, "age"),
            TextBox(weight, 'weight'),
            TextBox(owner, 'owner'),
            TextBox(location, 'location'),
            TextBox(description, 'description'),
            ElevatedButton(
                onPressed: () {
                  String name = this.name.text;
                  String breed = this.breed.text;
                  int? age = int.tryParse(this.age.text);
                  int? weight = int.tryParse(this.weight.text);
                  String owner = this.owner.text;
                  String location = this.location.text;
                  String description = this.description.text;
                  if (name.isNotEmpty &&
                      breed.isNotEmpty &&
                      owner.isNotEmpty &&
                      location.isNotEmpty &&
                      description.isNotEmpty &&
                      age != null &&
                      weight != null) {
                    Navigator.pop(
                        context,
                        Entity(
                            name: name,
                            breed: breed,
                            owner: owner,
                            location: location,
                            description: description,
                            age: age,
                            weight: weight));
                  } else {
                    if (name.isEmpty ||
                        breed.isEmpty ||
                        owner.isEmpty ||
                        location.isEmpty ||
                        description.isEmpty) {
                      popUpDialog(context, "Invalid input",
                          "Name, breed, owner, location or/and description are empty.");
                    } else if (age == null || weight == null) {
                      popUpDialog(context, "Invalid input",
                          "Age or/and weight are empty.");
                    }
                  }
                },
                child: const Text("Save"))
          ],
        ));
  }
}
