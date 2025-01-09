// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:practical_exam/api/api.dart';
import 'package:practical_exam/models/entity.dart';
import 'package:practical_exam/screens/entity_file.dart';
import 'package:practical_exam/screens/add_entity.dart';
import 'package:practical_exam/widgets/pop_up_dialog.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  _Analytics createState() => _Analytics();
}

class _Analytics extends State<Analytics> {
  late List<Entity> entities = [];
  bool isLoading = false;
  ApiService api = ApiService.instance;

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
          .getAllEvents()
          .timeout(const Duration(seconds: 2));

      if (serverEntities.isEmpty) {
        popUpDialog(context, "Information", "No events available.");
      } else {
        serverEntities.sort((a, b) {
          if (a.status == b.status) {
            return b.participants.compareTo(a.participants);
          }
          return a.status.compareTo(b.status);
        });

        serverEntities = serverEntities.take(5).toList();

        setState(() {
          entities = serverEntities;
        });
      }
    } catch (e) {
      popUpDialog(context, "Error", "Error connecting to the server");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics section'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        shadowColor: const Color.fromRGBO(0, 0, 0, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: ListTile(
                          title: Text(entities[index].toString()),
                          onTap: () {
                            // Handle onTap event
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: entities.length,
                    padding: const EdgeInsets.all(10),
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                  ),
                ),
              ],
            ),
    );
  }
}
