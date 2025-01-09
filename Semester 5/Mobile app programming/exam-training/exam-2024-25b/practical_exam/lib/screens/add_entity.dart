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
  late TextEditingController date;
  late TextEditingController type;
  late TextEditingController duration;
  late TextEditingController priority;
  late TextEditingController category;
  late TextEditingController description;

  @override
  void initState() {
    super.initState();
    date = TextEditingController();
    type = TextEditingController();
    duration = TextEditingController();
    priority = TextEditingController();
    category = TextEditingController();
    description = TextEditingController();
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
            TextBox(date, "yyyy-MM-dd"),
            TextBox(type, "type"),
            TextBox(duration, "duration 123.123 / 1.0"),
            TextBox(priority, "priority"),
            TextBox(category, "category"),
            TextBox(description, "description"),
            ElevatedButton(
                onPressed: () {
                  String date = this.date.text;
                  String type = this.type.text;
                  double? duration = double.tryParse(this.duration.text);
                  String priority = this.priority.text;
                  String category = this.category.text;
                  String description = this.description.text;
                  if (isDateValid(date) &&
                      type.isNotEmpty &&
                      priority.isNotEmpty &&
                      category.isNotEmpty &&
                      duration != null) {
                    Navigator.pop(
                        context,
                        Entity(
                            date: date,
                            type: type,
                            duration: duration,
                            priority: priority,
                            category: category,
                            description: description));
                  } else {
                    if (!isDateValid(date)) {
                      popUpDialog(context, "Invalid error", "Date is invalid");
                    } else if (type.isEmpty ||
                        priority.isEmpty ||
                        category.isEmpty ||
                        description.isEmpty) {
                      popUpDialog(context, "Invalid error",
                          "Type, priority, category or description are empty");
                    } else if (duration == null) {
                      popUpDialog(
                          context, "Invalid error", "Duration cannot be null");
                    }
                  }
                },
                child: const Text("Save"))
          ],
        ));
  }
}
