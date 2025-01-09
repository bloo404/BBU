// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practical_exam/models/entity.dart';
import 'package:practical_exam/widgets/pop_up_dialog.dart';
import 'package:practical_exam/widgets/text_box.dart';

class AddEntity extends StatefulWidget {
  const AddEntity({super.key});

  @override
  State<StatefulWidget> createState() => _AddEntityState();
}

class _AddEntityState extends State<AddEntity> {
  late TextEditingController nameFieldController;
  late TextEditingController organizerFieldController;
  late TextEditingController categoryFieldController;
  late TextEditingController capacityFieldController;
  late TextEditingController registeredFieldController;

  @override
  void initState() {
    super.initState();
    nameFieldController = TextEditingController();
    organizerFieldController = TextEditingController();
    categoryFieldController = TextEditingController();
    capacityFieldController = TextEditingController();
    registeredFieldController = TextEditingController();
  }

  bool isDateValid(String date) {
    try {
      DateTime formattedDate = DateFormat("yyyy-MM-dd").parseStrict(date);
      String formattedDateString =
          DateFormat("yyyy-MM-dd").format(formattedDate);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add entity"),
        ),
        body: ListView(
          children: [
            TextBox(nameFieldController, "name"),
            TextBox(organizerFieldController, "organizer"),
            TextBox(categoryFieldController, "category"),
            TextBox(capacityFieldController, "capacity"),
            TextBox(registeredFieldController, "registered"),
            ElevatedButton(
                onPressed: () {
                  String name = nameFieldController.text;
                  String organizer = organizerFieldController.text;
                  String category = categoryFieldController.text;
                  int? capacity = int.tryParse(capacityFieldController.text);
                  int? registered =
                      int.tryParse(registeredFieldController.text);
                  if (name.isNotEmpty &&
                      organizer.isNotEmpty &&
                      category.isNotEmpty &&
                      capacity != null &&
                      registered != null) {
                    Navigator.pop(
                        context,
                        Entity(
                            name: name,
                            organizer: organizer,
                            category: category,
                            capacity: capacity,
                            registered: registered));
                  } else {
                    if (name.isEmpty) {
                      popUpDialog(context, "Error", "Name cannot be empty.");
                    } else if (organizer.isEmpty) {
                      popUpDialog(context, "Invalid input",
                          "Organizer cannot be empty.");
                    } else if (category.isEmpty) {
                      popUpDialog(context, "Invalid input",
                          "Category cannot be empty.");
                    } else if (capacity == null) {
                      popUpDialog(context, "Invalid input",
                          "Capacity value cannot be empty.");
                    } else if (registered == null) {
                      popUpDialog(context, "Invalid input",
                          "Registered value cannot be empty.");
                    }
                  }
                },
                child: const Text("Save"))
          ],
        ));
  }
}
