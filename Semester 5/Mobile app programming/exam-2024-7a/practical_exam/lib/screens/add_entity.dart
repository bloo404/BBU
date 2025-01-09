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
  late TextEditingController name;
  late TextEditingController date;
  late TextEditingController details;
  late TextEditingController status;
  late TextEditingController participants;
  late TextEditingController type;

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    date = TextEditingController();
    details = TextEditingController();
    status = TextEditingController();
    participants = TextEditingController();
    type = TextEditingController();
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
            TextBox(name, "name"),
            TextBox(date, "date: yyyy-mm-dd"),
            TextBox(details, "details"),
            TextBox(status, 'status'),
            TextBox(participants, 'participants number'),
            TextBox(type, 'type of activity'),
            ElevatedButton(
                onPressed: () {
                  String name = this.name.text;
                  String date = this.date.text;
                  String details = this.details.text;
                  String status = this.status.text;
                  int? participants = int.tryParse(this.participants.text);
                  String type = this.type.text;
                  if (isDateValid(date) &&
                      name.isNotEmpty &&
                      date.isNotEmpty &&
                      details.isNotEmpty &&
                      status.isNotEmpty &&
                      type.isNotEmpty &&
                      participants != null) {
                    Navigator.pop(
                        context,
                        Entity(
                            name: name,
                            date: date,
                            details: details,
                            status: status,
                            participants: participants,
                            type: type));
                  } else {
                    if (!isDateValid(date)) {
                      popUpDialog(context, "Invalid input", "Date is invalid");
                    } else if (name.isEmpty ||
                        details.isEmpty ||
                        status.isEmpty ||
                        type.isEmpty) {
                      popUpDialog(context, "Invalid input",
                          "Name, details, status or/and type are empty");
                    } else if (participants == null) {
                      popUpDialog(context, "Invalid input",
                          "Participants cannot be null");
                    }
                  }
                },
                child: const Text("Save"))
          ],
        ));
  }
}
