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
  bool what_to_do = true;

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
          .getAll()
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

  Future<void> reservedEntities() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<Entity> serverEntities = await ApiService.instance
          .getReserved()
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
        title: const Text("Client Section"),
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
                                // two icon buttons for reserving and borrowing
                                title: Text(entity.title),
                                subtitle: Text(entity.author + entity.genre),
                                trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            api.reserveEntity(entity);
                                          }),
                                      IconButton(
                                          icon: const Icon(Icons.book),
                                          onPressed: () {
                                            api.borrowEntity(entity);
                                          })
                                    ]));
                          },
                        )
                      : const Center(
                          child: Text("No entities available"),
                        ),
                ),
                IconButton(
                    onPressed: () {
                      // change list from normal to reserved and vice versa based on the one we re at
                      if (what_to_do) {
                        reservedEntities();
                        what_to_do = false;
                      } else {
                        getEntities();
                        what_to_do = true;
                      }
                    },
                    icon: const Icon(Icons.tv))
              ],
            ),
    );
  }
}
