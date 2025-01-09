// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
// ignore: unused_import
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
  late TextEditingController team;
  late TextEditingController details;
  late TextEditingController status;
  late TextEditingController participants;
  late TextEditingController type;

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    team = TextEditingController();
    details = TextEditingController();
    status = TextEditingController();
    participants = TextEditingController();
    type = TextEditingController();
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
            TextBox(team, "team"),
            TextBox(details, "details"),
            TextBox(status, "status"),
            TextBox(participants, "participants"),
            TextBox(type, "type"),
            ElevatedButton(
                onPressed: () {
                  String name = this.name.text;
                  String team = this.team.text;
                  String details = this.details.text;
                  String status = this.status.text;
                  int? participants = int.tryParse(this.participants.text);
                  String type = this.type.text;
                  if (name.isNotEmpty &&
                      team.isNotEmpty &&
                      details.isNotEmpty &&
                      status.isNotEmpty &&
                      type.isNotEmpty &&
                      participants != null) {
                    Navigator.pop(
                        context,
                        Entity(
                            name: name,
                            team: team,
                            details: details,
                            status: status,
                            participants: participants,
                            type: type));
                  } else {
                    if (name.isEmpty ||
                        team.isEmpty ||
                        details.isEmpty ||
                        status.isEmpty ||
                        type.isEmpty) {
                      popUpDialog(context, "Invalid input",
                          "Name, team, details, status or type is empty");
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
