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
  late TextEditingController titleFieldController;
  late TextEditingController authorFieldController;
  late TextEditingController genreFieldController;
  late TextEditingController quantityFieldController;
  late TextEditingController reservedFieldController;

  @override
  void initState() {
    super.initState();
    titleFieldController = TextEditingController();
    authorFieldController = TextEditingController();
    genreFieldController = TextEditingController();
    quantityFieldController = TextEditingController();
    reservedFieldController = TextEditingController();
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
          title: const Text("Add book"),
        ),
        body: ListView(
          children: [
            TextBox(titleFieldController, "title"),
            TextBox(authorFieldController, "author"),
            TextBox(genreFieldController, "genre"),
            TextBox(quantityFieldController, "quantity"),
            TextBox(reservedFieldController, "reserved"),
            ElevatedButton(
                onPressed: () {
                  String title = titleFieldController.text;
                  String author = authorFieldController.text;
                  String genre = authorFieldController.text;
                  int? quantity = int.tryParse(quantityFieldController.text);
                  int? reserved = int.tryParse(reservedFieldController.text);
                  if (title.isNotEmpty &&
                      author.isNotEmpty &&
                      genre.isNotEmpty &&
                      quantity != null &&
                      reserved != null) {
                    Navigator.pop(
                        context,
                        Entity(
                            title: title,
                            author: author,
                            genre: genre,
                            quantity: quantity,
                            reserved: reserved));
                  } else if (title.isEmpty) {
                    popUpDialog(
                        context, "Input invalid", "Title cannot be empty");
                  } else if (author.isEmpty) {
                    popUpDialog(
                        context, "Input invalid", "Author cannot be empty");
                  } else if (genre.isEmpty) {
                    popUpDialog(
                        context, "Input invalid", "Genre cannot be empty");
                  } else if (quantity == null) {
                    popUpDialog(
                        context, "Input invalid", "Quantity cannot be null");
                  } else if (reserved == null) {
                    popUpDialog(
                        context, "Input invalid", "Reserved cannot be null");
                  }
                },
                child: const Text("Save"))
          ],
        ));
  }
}
