// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:practical_exam/api/api.dart';
import 'package:practical_exam/database/database_helper.dart';
import 'package:practical_exam/models/entity.dart';

class ManageSection extends StatefulWidget {
  const ManageSection({super.key});

  @override
  _ManageSectionState createState() => _ManageSectionState();
}

class _ManageSectionState extends State<ManageSection> {
  List<Entity> entities = [];
  bool isLoading = false;
  Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    getEntities();
  }

  Future<void> getEntities() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<Entity> serverEntities = await ApiService.instance
          .getEntries()
          .timeout(const Duration(seconds: 2));

      for (var serverEntity in serverEntities) {
        if (!entities.contains(serverEntity)) {
          await DatabaseHelper.addEntity(serverEntity);
          entities.add(serverEntity);
        }
      }
    } catch (e) {
      entities = await DatabaseHelper.getAll();
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Progress Section"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: entities.isNotEmpty
                      ? buildSortedMonthList()
                      : const Center(
                          child: Text("No entities available"),
                        ),
                ),
              ],
            ),
    );
  }

  Widget buildSortedMonthList() {
    entities.sort((a, b) => b.duration.compareTo(a.duration));

    return ListView.builder(
      itemCount: entities.length,
      itemBuilder: (context, index) {
        Entity entity = entities[index];
        List<String> dateParts = entity.date.split('-');
        DateTime dateTime = DateTime(
          int.parse(dateParts[0]),
          int.parse(dateParts[1]),
          int.parse(dateParts[2]),
        );
        int month = dateTime.month;

        return ListTile(
          title: Text("Month: $month"),
          subtitle: Text("Total Duration: ${entity.duration}"),
          onTap: () {
            // nothing here
          },
        );
      },
    );
  }
}
