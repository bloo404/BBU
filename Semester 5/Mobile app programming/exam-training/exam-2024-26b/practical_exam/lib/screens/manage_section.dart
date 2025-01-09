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
  ApiService api = ApiService.instance;

  @override
  void initState() {
    super.initState();
    entities.clear();
    getEntities();
  }

  Future<void> getEntities() async {
    entities.clear();
    setState(() {
      isLoading = true;
    });

    try {
      List<Entity> serverEntities = await ApiService.instance
          .getInProgress()
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
        title: const Text("Participant section"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: entities.isNotEmpty
                      ? ListView.builder(
                          itemCount: entities.length,
                          itemBuilder: (context, index) {
                            Entity entity = entities[index];
                            return ListTile(
                              title: Text('${entity.id} ${entity.name}'),
                              subtitle: Text('${entity.team} ${entity.type}'),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  api.enroll(entity);
                                },
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text("No entities available"),
                        ),
                ),
              ],
            ),
    );
  }
}
